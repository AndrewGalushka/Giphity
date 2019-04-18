//
//  RandomGifService.swift
//  Giphity
//
//  Created by Galushka on 4/18/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

class RandomGifService: RandomGifServiceType {
    private let gifFetcher: GifFetcherType
    private let requestManager: RandomGifRequestPerformable
    
    init(gifFetcher: GifFetcherType, requestManager: RandomGifRequestPerformable) {
        self.gifFetcher = gifFetcher
        self.requestManager = requestManager
    }
    
    func randomGif() -> Promise<UIImage> {
        
        return PromiseKit.firstly {
            self.requestManager.randomGif()
        }.then { (response) -> Promise<UIImage> in
            let gifObject = try self.gifObject(from: response)
            return self.gifFetcher.fetch(gifObject)
        }
    }
    
    func gifObject(from response: GiphyResponse<GifObject>) throws -> GifObject {
        guard let gifObject = response.data else { throw RandomGifServiceError.emptyData }
        return gifObject
    }
}
