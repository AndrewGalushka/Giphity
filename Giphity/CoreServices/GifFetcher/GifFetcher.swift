//
//  GifFetcher.swift
//  Giphity
//
//  Created by Galushka on 4/9/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit
import PromiseKit


class GifFetcher: GifFetcherType {
   
    let gifEngine: GifDataEngineType
    
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
            let urlString = gifObject.images?.imageObject(for: .downsized)?.url,
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
        let stabError = NSError(domain: "", code: 0, userInfo: nil)
        
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            if let data = data, let gif = self?.gifEngine.gifImage(from: data) {
                competion(.success(gif))
            } else if let error = error {
                competion(.failure(error))
            } else {
                competion(.failure(stabError))
            }
        }
        
        task.resume()
    }
}
