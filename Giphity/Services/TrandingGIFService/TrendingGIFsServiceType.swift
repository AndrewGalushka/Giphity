//
//  TrandingGIFServiceType.swift
//  Giphity
//
//  Created by Galushka on 5/20/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import PromiseKit

protocol TrendingGIFsServiceType {
    func trendingGIFs() -> Promise<GiphySearchResponse>
    func trendingGIFs(offset: Int) -> Promise<GiphySearchResponse>
    func trendingGIFs(limit: Int, offset: Int) -> Promise<GiphySearchResponse>
}
