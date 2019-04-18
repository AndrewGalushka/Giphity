//
//  GifFetcher+Error.swift
//  Giphity
//
//  Created by Galushka on 4/18/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

extension GifFetcher {
    enum GifFetcherError: Error {
        case coundNotConvertDataToGif
        case unknown
        
        var localizedDescription: String {
            switch self {
            case .coundNotConvertDataToGif:
                return "Could not convert data to gif"
            case .unknown:
                return "Unknown error"
            }
        }
    }
}
