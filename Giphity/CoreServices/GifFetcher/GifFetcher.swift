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

class GifCache {
    private let storage = NSCache<AnyObject, AnyObject>()
    private var operationQueue: OperationQueue = {
       let queue = OperationQueue()
        queue.name = "com.gif.cache.operation.queue"
        queue.maxConcurrentOperationCount = 1
        
        return queue
    }()
    
    func save(_ image: Data, url: URL) {
        operationQueue.addOperation { [weak self] in
            self?.storage.setObject(image as NSData, forKey: url.path as AnyObject)
        }
    }
    
    func image(url: URL) -> Guarantee<Data?> {
        return Guarantee<Data?>.init(resolver: { (resolver) in
            operationQueue.addOperation { [weak self] in
                let image = self?.storage.object(forKey: url.path as AnyObject) as? Data
                resolver(image)
            }
        })
    }
}

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
    
    func fetch(_ gifObject: GifObject) -> Promise<UIImage> {
        let (promise, promiseResolver) = Promise<UIImage>.pending()
        
        self.fetch(gifObject) { (result) in
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
    
    func fetch(_ gifObject: GifObject, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void) {
        let stabError = NSError(domain: "", code: 0, userInfo: nil)
        
        guard
            let urlString = gifObject.images?.imageObject(for: .preview_gif)?.url,
            let url = URL(string: urlString)
        else {
            competion(.failure(stabError))
            return
        }
        
        self.fetch(url, competion: competion)
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
        

        cache.image(url: url).done(on: processingQueue) { (imageFromCache) in
            
            if let imageFromCache = imageFromCache {
                
                if let gifImage = self.gifEngine.gifImage(from: imageFromCache) {
                    competion(.success(gifImage))
                } else {
                    competion(.failure(GifFetcherError.coundNotConvertDataToGif))
                }
            }
            
            Alamofire.request(url, method: .get).responseData { (dataResponse) in
                
                self.processingQueue.async { [weak self] in
//                    guard let `self` = self else { return }
                    
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
