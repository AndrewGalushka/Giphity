//
//  SearchGIFsPaginationService.swift
//  Giphity
//
//  Created by Galushka on 5/8/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

class SearchGIFsPaginationService: SearchGIFsPaginationServiceType {
    
    // MARK: - Properties(Public)
    
    weak var delegate: SearchGIFsPaginationServiceDelegate?
    
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
    
    private let searchGIFsService: SearchGIFsServiceType
    private let paginationController = PaginationController()
    private var errorDomain: String { return "com.search.gifs.pagination.service" }
    
    // MARK: - Initializers
    
    init(searchGIFsService: SearchGIFsServiceType) {
        self.searchGIFsService = searchGIFsService
    }
    
    // MARK: - SearchGIFsPaginationServiceType imp
    
    func searchGIFs(by query: String) {

        let searchTask = searchGIFsService.searchGifs(by: query, limit: Int(self.limit), offset: 0)
        
        paginationController.firstExecution(sessionID: query, task: searchTask).done { (searchTaskPromise) -> Void in
            
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
            return self.searchGIFsService.searchGifs(by: sessionID, limit: Int(limit), offset: offset)
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
}
