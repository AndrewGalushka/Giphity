//
//  SearchGIFsService.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

class SearchGIFsService: SearchGIFsServiceType {
    private let requestManager: GiphyRequestManager
    
    // MARK: - Initializers
    
    init(requestManager: GiphyRequestManager) {
        self.requestManager = requestManager
    }
    
    // MARK: - SearchGIFsServiceType
    
    func searchGifs(by name: String, limit: Int, offset: Int) -> Promise<GiphySearchResponse> {
       return self.requestManager.searchGifs(name: name, limit: limit, offset: offset)
    }
    
    func searchGifs(by name: String, limit: Int) -> Promise<GiphySearchResponse> {
       return self.requestManager.searchGifs(name: name, limit: limit)
    }
    
    func searchGifs(by name: String) -> Promise<GiphySearchResponse> {
        return self.requestManager.searchGifs(name: name)
    }
}
