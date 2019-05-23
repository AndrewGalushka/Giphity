//
//  TrandingGIFService.swift
//  Giphity
//
//  Created by Galushka on 5/20/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

class TrendingGIFsService: TrendingGIFsServiceType {
    
    // MARK: Properties(Private)
    
    private let requestManager: TrendingGIFsRequestPerformable
    
    // MARK: Initializers
    
    init(requestManager: TrendingGIFsRequestPerformable) {
        self.requestManager = requestManager
    }
    
    // MARK: TrendingGIFsServiceType Imp
    
    func trendingGIFs() -> Promise<GiphySearchResponse> {
        return self._trendingGIFs()
    }
    
    func trendingGIFs(offset: Int) -> Promise<GiphySearchResponse> {
        return self._trendingGIFs(offset: offset)
    }
    
    func trendingGIFs(limit: Int, offset: Int) -> Promise<GiphySearchResponse> {
        return self._trendingGIFs(limit: limit, offset: offset)
    }
    
    // MARK: Methods(Private)
    
    private func _trendingGIFs(limit: Int = 15, offset: Int = 0) -> Promise<GiphySearchResponse> {
        return requestManager.trendingGIFs(limit: limit, offset: offset)
    }
}
