//
//  SearchGIFsServiceType.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol SearchGIFsServiceType {
    func searchGifs(by name: String,
                    limit: Int,
                    offset: Int) -> Promise<GiphySearchResponse>
    
    func searchGifs(by name: String,
                    limit: Int) -> Promise<GiphySearchResponse>
    
    func searchGifs(by name: String) -> Promise<GiphySearchResponse>
}
