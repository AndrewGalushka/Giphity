//
//  GiphySearchResponse.swift
//  Giphity
//
//  Created by Galushka on 4/10/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

struct GiphySearchResponse: Decodable {
    let meta: GiphyResponseMeta
    let gifObjects: [GifObject]?
    let pagination: GiphyPagination?
    
    enum CodingKeys: String, CodingKey {
        case meta
        case gifObjects = "data"
        case pagination
    }
}

struct GiphyPagination: Decodable {
    let totalCount: Int
    let count: Int
    let offset: Int
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count
        case offset
    }
}
