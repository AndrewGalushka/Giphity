//
//  GiphyPagination.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

struct GiphyPagination: Decodable {
    
    /// Position in pagination.
    let offset: Int
    
    /// Total number of items available.
    let totalCount: Int
    
    /// Total number of items returned.
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count
        case offset
    }
}
