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
    let cache = GifCache()
    
    private let processingQueue = DispatchQueue(label: "gif.fetcher.processing.queue", qos: DispatchQoS.userInitiated)
    
    init(gifDataEngine: GifDataEngine = GifDataEngine()) {
        self.gifEngine = gifDataEngine
    }
    
    func fetch(_ url: String) -> Promise<UIImage> {
        let (promise, promiseResolver) = Promise<UIImage>.pending()
        
        self.fetch(url) { (result) in
            promiseResolver.resolve(result)
        }
        
        return promise
    }
    
    func fetch(_ url: URL) -> Promise<UIImage> {
        let (promise, promiseResolver) = Promise<UIImage>.pending()
        
        self.fetch(url) { (result) in
            promiseResolver.resolve(result)
        }
        
        return promise
    }
    
    func fetch(_ url: String, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void) {
        guard
            let url = URL(string: url)
        else {
            competion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            return
        }
        
        self.fetch(url, competion: competion)
    }
    
    func fetch(_ url: URL, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void) {

        self.processingQueue.async { [weak self] in
            
            if let imageFromCache = self?.cache.image(url: url) {
                
                if let gifImage = self?.gifEngine.gifImage(from: imageFromCache) {
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
                        
                        if let gifImage = self?.gifEngine.gifImage(from: data) {
                            self?.cache.save(data, url: url)
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
