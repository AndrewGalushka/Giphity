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
    
    func fetchGIF(by url: URL) -> Promise<UIImage> {
        return self.fetchGIF(by: url, shouldUseCache: true)
    }
    
    func fetchGIF(by url: URL, shouldUseCache: Bool) -> Promise<UIImage> {
        let (promise, promiseResolver) = Promise<UIImage>.pending()
        
        self.fetchGIF(by: url, shouldUseCache: shouldUseCache) { (result) in
            promiseResolver.resolve(result)
        }
        
        return promise
    }
    
    func fetchGIF(by url: URL, shouldUseCache useCache: Bool, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void) {
        
        self.processingQueue.async { [weak self] in
            guard let strongSelf = self else { return }
            
            if useCache, let cachedGIFData = self?.cache.gifData(byURL: url){
                if let gifImage = self?.gifEngine.createGIFImage(using: cachedGIFData) {
                    competion(.success(gifImage))
                } else {
                    competion(.failure(GifFetcherError.coundNotConvertDataToGif))
                }
            }
            
            strongSelf.fetchData(using: url).done(on: strongSelf.processingQueue) { [weak self] in
                
                if let gifImage = self?.gifEngine.createGIFImage(using: $0) {
                    self?.cache(data: $0, byURL: url, ifFlagIsTrue: useCache)
                    competion(.success(gifImage))
                } else {
                    competion(.failure(GifFetcherError.coundNotConvertDataToGif))
                }
            }.catch(on: strongSelf.processingQueue) {
                 competion(.failure($0))
            }
        }
    }
    
    private func fetchData(using url: URL) -> Promise<Data> {
        let (promise, resolver) = Promise<Data>.pending()
        
        Alamofire.request(url).responseData(completionHandler: { (dataResponse) in
            
            if let error = dataResponse.error {
                resolver.reject(error)
            } else if let data = dataResponse.data {
                resolver.fulfill(data)
            } else {
                resolver.reject(GifFetcherError.unknown)
            }
        })
        
        return promise
    }
    
    func cache(data: Data, byURL url: URL, ifFlagIsTrue isNeedToCacheData: Bool) {
        
        if isNeedToCacheData {
            self.cache.save(gifData: data, byURL: url)
        }
    }
}
