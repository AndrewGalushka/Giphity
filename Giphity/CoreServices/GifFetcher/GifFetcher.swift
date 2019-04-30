//
//  GifFetcher.swift
//  Giphity
//
//  Created by Galushka on 4/9/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire

class GifFetcher: GifFetcherType {
    
    let gifEngine: GifDataEngineType
    let cache: GifCacheType
    
    private let processingQueue = DispatchQueue(label: "gif.fetcher.processing.queue", qos: DispatchQoS.userInitiated)
    
    init(gifDataEngine: GifDataEngine = GifDataEngine(), cache: GifCacheType = GifCache()) {
        self.gifEngine = gifDataEngine
        self.cache = cache
    }
    
    func fetch(_ url: URL) -> Promise<UIImage> {
        let (promise, promiseResolver) = Promise<UIImage>.pending()
        
        self.fetch(url) { (result) in
            promiseResolver.resolve(result)
        }
        
        return promise
    }
    
    func fetch(_ url: URL, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void) {
        
        self.processingQueue.async { [weak self] in
            
            if let cachedGIFData = self?.cache.gifData(byURL: url){
                if let gifImage = self?.gifEngine.createGIFImage(using: cachedGIFData) {
                    competion(.success(gifImage))
                } else {
                    competion(.failure(GifFetcherError.coundNotConvertDataToGif))
                }
            }
            
            Alamofire.request(url, method: .get).responseData { [weak self] (dataResponse) in
                
                self?.processingQueue.async { [weak self] in
                    
                    if let error = dataResponse.error {
                        competion(.failure(error))
                    } else if let data = dataResponse.data {
                        
                        if let gifImage = self?.gifEngine.createGIFImage(using: data) {
                            self?.cache.save(gifData: data, byURL: url)
                            competion(.success(gifImage))
                        } else {
                            competion(.failure(GifFetcherError.coundNotConvertDataToGif))
                        }
                    } else {
                        competion(.failure(GifFetcherError.unknown))
                    }
                }
            }
        }
    }
    
}
