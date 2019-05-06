//
//  GiphyRequestManager+SearchGIFs.swift
//  Giphity
//
//  Created by Galushka on 5/6/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

extension GiphyRequestManager: SearchGIFsRequestPerformable {
    
    func searchGifs(name query: String, limit: Int, offset: Int) -> Promise<GiphySearchResponse> {
        return self._searchGifs(name: query, limit: limit, offset: offset)
    }
    
    func searchGifs(name query: String,
                    limit: Int) -> Promise<GiphySearchResponse> {
        return self._searchGifs(name: query, limit: limit)
    }
    
    func searchGifs(name query: String) -> Promise<GiphySearchResponse> {
        return self._searchGifs(name: query)
    }
    
    private func _searchGifs(name query: String, limit: Int = 25, offset: Int = 0) -> Promise<GiphySearchResponse> {
        let queryItems = [URLQueryItem(name: "q", value: query),
                          URLQueryItem(name: "limit", value: "\(limit)"),
                          URLQueryItem(name: "offset", value: "\(offset)")]
        
        let requestCommand = HTTPRequestCommand(method: .get, path: "/gifs/search", queryItems: queryItems)
        return self.execute(requestCommand)
    }
}
