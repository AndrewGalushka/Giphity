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
    
    func randomGif(ofSize size: ImageObject.ImageType) -> Promise<UIImage> {
        
        return PromiseKit.firstly {
            self.requestManager.randomGif()
        }.then { (response) -> Promise<UIImage> in
            let url = try self.gifURL(from: response, size: size)
            return self.gifFetcher.fetchGIF(by: url)
        }
    }
    
    func gifURL(from response: GiphyResponse<GifObject>, size: ImageObject.ImageType) throws -> URL {
        guard let gifObject = response.data, let urlString = gifObject.images?.imageObject(for: size)?.url, let url = URL(string: urlString) else {
            throw RandomGifServiceError.emptyData
        }
        
        return url
    }
}
