//
//  RandomGifServiceError.swift
//  Giphity
//
//  Created by Galushka on 4/18/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

enum RandomGifServiceError: Error {
    case emptyData
    
    var localizedDescription: String {
        switch self {
        case .emptyData:
            return "Data is empty"
        }
    }
}
