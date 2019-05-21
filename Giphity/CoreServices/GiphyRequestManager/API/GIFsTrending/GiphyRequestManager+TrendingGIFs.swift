//
//  GiphyRequestManager+TrendingGIFs.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

extension GiphyRequestManager: TrendingGIFsRequestPerformable {
    
    func trendingGIFs() -> Promise<GiphySearchResponse> {
        return self._trendingGIFs()
    }
    
    func trendingGIFs(limit: Int) -> Promise<GiphySearchResponse> {
        return self._trendingGIFs(limit: limit)
    }
    
    func trendingGIFs(limit: Int, offset: Int) -> Promise<GiphySearchResponse> {
        return self._trendingGIFs(limit: limit, offset: offset)
    }
    
    private func _trendingGIFs(limit: Int = 15, offset: Int = 0) -> Promise<GiphySearchResponse> {
        let queryItems = [URLQueryItem(name: "limit", value: "\(limit)"),
                          URLQueryItem(name: "offset", value: "\(offset)")]
        
        let requestCommand = HTTPRequestCommand(method: .get, path: "/gifs/trending", queryItems: queryItems)
        return self.execute(requestCommand)
    }
}
