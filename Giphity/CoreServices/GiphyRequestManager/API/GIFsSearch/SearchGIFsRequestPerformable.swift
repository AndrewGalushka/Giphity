//
//  SearchGIFsRequestPerformable.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol SearchGIFsRequestPerformable {
    func searchGifs(name query: String,
                    limit: Int,
                    offset: Int) -> Promise<GiphySearchResponse>

    func searchGifs(name query: String,
                    limit: Int) -> Promise<GiphySearchResponse>
    
    func searchGifs(name query: String) -> Promise<GiphySearchResponse>
}
