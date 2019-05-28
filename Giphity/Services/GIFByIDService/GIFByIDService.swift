//
//  GIFByIDService.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

class GIFByIDService: GIFByIDServiceType {
    
    // MARK: Properties(Private)
    
    private let requestManager: GIFByIDRequestPerformable
    
    // MARK: Initializers
    
    init(requestManager: GIFByIDRequestPerformable) {
        self.requestManager = requestManager
    }
    
    // MARK: GIFByIDServiceType Imp

    func gifObjectByID(_ gifID: String) -> Promise<GiphyResponse<GifObject>> {
        return requestManager.gifByID(gifID)
    }
}


