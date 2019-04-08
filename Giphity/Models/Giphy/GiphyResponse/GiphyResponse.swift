//
//  GiphyResponse.swift
//  Giphity
//
//  Created by Galushka on 4/8/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

struct GiphyResponse<DataType: Decodable>: Decodable {
    let data: DataType?
    let meta: Meta
}

extension GiphyResponse {
    struct Meta: Decodable {
        let status: Int
        let msg: String
    }
}
