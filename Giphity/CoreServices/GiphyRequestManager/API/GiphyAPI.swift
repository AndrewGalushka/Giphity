//
//  GiphyAPI.swift
//  Giphity
//
//  Created by Galushka on 5/3/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import Alamofire

protocol HTTPRequest {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}
