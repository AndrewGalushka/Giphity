//
//  GifDataEngine+Error.swift
//  Giphity
//
//  Created by Galushka on 4/19/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

extension GifDataEngine {
    
    enum GifDataEngineError: Error {
        case couldNotSourceCreateImageSource
        case empty
        
        var localizedDescription: String {
            switch self {
            case .couldNotSourceCreateImageSource:
                return "Could not create image source"
            case .empty:
                return "No images were found"
            }
        }
    }
}
