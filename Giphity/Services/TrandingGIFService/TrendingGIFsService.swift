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
    private let requestManager: TrendingGIFsRequestPerformable
    
    init(requestManager: TrendingGIFsRequestPerformable) {
        self.requestManager = requestManager
    }
    
    func trendingGIFs() -> Promise<GiphySearchResponse> {
        return requestManager.trendingGIFs()
    }
}
