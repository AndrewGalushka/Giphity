//
//  TrendingGIFsPaginationService.swift
//  Giphity
//
//  Created by Galushka on 5/23/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

class TrendingGIFsPaginationService: TrendingGIFsPaginationServiceType {
    
    // MARK: - Properties(Public)
    
    weak var delegate: TrendingGIFsPaginationServiceDelegate?
    
    /// Maximum of result can be fetched is 25
    var limit: UInt {
        get {
            return paginationController.limit
        }
        
        set (value) {
            paginationController.limit = value
        }
    }
    
    var isFetchingInProcess: Bool {
        return paginationController.isFetchingInProgress
    }
    
    // MARK: - Properties(Private)
    
    private let trendingGIFsService: TrendingGIFsServiceType
    private let paginationController = PaginationController()
    private var errorDomain: String { return "com.trending.gifs.pagination.service" }
    
    // MARK: - Initializers
    
    init(trendingGIFsService: TrendingGIFsServiceType) {
        self.trendingGIFsService = trendingGIFsService
    }
    
    // MARK: - SearchGIFsPaginationServiceType imp
    
    func firstBatch() {
        let paginationSessionID = self.createUniqueID()
        
        let searchTask = trendingGIFsService.trendingGIFs(limit: Int(self.limit), offset: 0)
        
        paginationController.firstExecution(sessionID: paginationSessionID, task: searchTask).done { (searchTaskPromise) -> Void in
            
            searchTaskPromise.done { [weak self] (response) in
                guard let strongSelf = self else { return }
                
                guard let gifObjects = response.gifObjects else {
                    
                    let error = NSError(domain: strongSelf.errorDomain, code: -1, userInfo: nil)
                    strongSelf.delegate?.searchGIFsPaginationService(strongSelf,
                                                                     didFailToFetchFirstBatch: error)
                    return
                }
                
                if let pagination = response.pagination {
                    self?.paginationController.savePagination(pagination)
                }
                
                strongSelf.delegate?.searchGIFsPaginationService(strongSelf,
                                                                 didFetchFirstBatch: gifObjects)
                }.catch { [weak self] (error) in
                    guard let strongSelf = self else { return }
                    strongSelf.paginationController.reset()
                    strongSelf.delegate?.searchGIFsPaginationService(strongSelf, didFailToFetchFirstBatch: error)
            }
            
            }.catch {
                
                if let error = $0 as? PaginationController.FirstExecutionError {
                    
                    switch error {
                    case .identifierExpired:
                        break
                    }
                }
        }
    }
    
    func nextBatch() {
        
        let nextBatchTask = { (sessionID: String, limit: UInt, offset: Int) -> Promise<GiphySearchResponse> in
            return self.trendingGIFsService.trendingGIFs(limit: Int(limit), offset: offset)
        }
        
        self.paginationController.nextExecution(task: nextBatchTask).done { nextBatchTaskPromise in
            
            nextBatchTaskPromise.done { [weak self] (response) in
                guard let strongSelf = self else { return }
                
                guard let gifObjects = response.gifObjects else {
                    let error = NSError(domain: strongSelf.errorDomain, code: -1, userInfo: nil)
                    strongSelf.delegate?.searchGIFsPaginationService(strongSelf,
                                                                     didFailToFetchNextBatch: error)
                    return
                }
                
                if let pagination = response.pagination {
                    self?.paginationController.savePagination(pagination)
                }
                
                strongSelf.delegate?.searchGIFsPaginationService(strongSelf,
                                                                 didFetchNextBatch: gifObjects)
                }.catch { [weak self] (error) in
                    guard let strongSelf = self else { return }
                    strongSelf.delegate?.searchGIFsPaginationService(strongSelf, didFailToFetchNextBatch: error)
            }
            
            }.catch { (error) in
                
                if let error = error as? PaginationController.NextExecutionError {
                    
                    switch error {
                    case .nextExecutionCalledBeforeFirst:
                        break
                    case .paginationIsEmpty:
                        break
                    case .endOfList:
                        break
                    case .identifierExpired:
                        break
                        
                    }
                }
        }
    }
    
    private func createUniqueID() -> String {
        return "\(Date().timeIntervalSince1970)"
    }
}
