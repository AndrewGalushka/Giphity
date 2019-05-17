//
//  TrendingGIFsRequestPerformable.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol TrendingGIFsRequestPerformable {
    func trendingGIFs(limit: Int, offset: Int) -> Promise<GiphySearchResponse>
    
    func trendingGIFs(offset: Int) -> Promise<GiphySearchResponse>
    
    func trendingGIFs() -> Promise<GiphySearchResponse>
}
