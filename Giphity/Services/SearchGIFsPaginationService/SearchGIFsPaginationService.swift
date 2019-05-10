//
//  SearchGIFsPaginationService.swift
//  Giphity
//
//  Created by Galushka on 5/8/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

class SearchGIFsPaginationService: SearchGIFsPaginationServiceType {
    
    // MARK: - Properties(Public)
    
    weak var delegate: SearchGIFsPaginationServiceDelegate?
    var limit: UInt = UInt(15)
    
    // MARK: - Properties(Private)
    
    private let searchGIFsService: SearchGIFsServiceType
    private var searchQuery: String?
    private var pagination: GiphyPagination?
    private(set) var isFetchingInProcess: Bool = false
    
    private var errorDomain: String { return "com.search.gifs.pagination.service" }
    
    // MARK: - Initializers
    
    init(searchGIFsService: SearchGIFsServiceType) {
        self.searchGIFsService = searchGIFsService
    }
    
    // MARK: - SearchGIFsPaginationServiceType imp
    
    func searchGIFs(by name: String) {
        self.searchQuery = name
        self.isFetchingInProcess = true
        
        searchGIFsService.searchGifs(by: name, limit: Int(self.limit), offset: 0).done { [weak self] (response) in
            guard let strongSelf = self, name == strongSelf.searchQuery else {
                return
            }
            
            guard let gifObjects = response.gifObjects else {
                strongSelf.reset()
    
                let error = NSError(domain: strongSelf.errorDomain, code: -1, userInfo: nil)
                strongSelf.delegate?.searchGIFsPaginationService(strongSelf,
                                                            didFailToFetchFirstBatch: error)
                return
            }
        
            if let pagination = response.pagination {
                strongSelf.save(pagination: pagination)
            }
            
            strongSelf.delegate?.searchGIFsPaginationService(strongSelf,
                                                             didFetchFirstBatch: gifObjects)
        }.catch { [weak self] (error) in
            guard let strongSelf = self, name == self?.searchQuery else { return }
            
            strongSelf.reset()
            strongSelf.delegate?.searchGIFsPaginationService(strongSelf, didFailToFetchFirstBatch: error)
        }.finally { [weak self] in
            guard let strongSelf = self, name == strongSelf.searchQuery else {
                return
            }
            
            self?.isFetchingInProcess = false
        }
    }
    
    func nextBatch() {
        guard let searchQuery = self.searchQuery, let pagination = self.pagination else {
            return
        }
        
        let offset = pagination.offset + pagination.count
        guard offset < pagination.totalCount else { return }
        
        self.isFetchingInProcess = true
        
        self.searchGIFsService.searchGifs(by: searchQuery, limit: Int(self.limit), offset: offset).done { [weak self] (response) in
            guard let strongSelf = self, searchQuery == strongSelf.searchQuery else { return }
            
            guard let gifObjects = response.gifObjects else {
                let error = NSError(domain: strongSelf.errorDomain, code: -1, userInfo: nil)
                strongSelf.delegate?.searchGIFsPaginationService(strongSelf,
                                                                 didFailToFetchNextBatch: error)
                return
            }
            
            if let pagination = response.pagination {
                strongSelf.save(pagination: pagination)
            }
            
            strongSelf.delegate?.searchGIFsPaginationService(strongSelf,
                                                             didFetchNextBatch: gifObjects)
            
        }.catch { [weak self] (error) in
            guard let strongSelf = self, searchQuery == self?.searchQuery else {
                return
            }
            
            strongSelf.delegate?.searchGIFsPaginationService(strongSelf, didFailToFetchNextBatch: error)
        }.finally { [weak self] in
            guard let strongSelf = self, searchQuery == strongSelf.searchQuery else {
                return
            }
            
            self?.isFetchingInProcess = false
        }
    }
    
    func reset() {
        self.searchQuery = nil
        self.pagination = nil
        self.isFetchingInProcess = false
    }
    
    func save(pagination giphyPagination: GiphyPagination) {
        self.pagination = giphyPagination
    }
}
