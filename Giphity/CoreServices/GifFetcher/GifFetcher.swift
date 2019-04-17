//
//  GifFetcher.swift
//  Giphity
//
//  Created by Galushka on 4/9/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit
import PromiseKit


class GifFetcher {
    
    let gifEngine: GifDataEngine = GifDataEngine()
    
    func fetch(_ url: String) -> Promise<UIImage> {
        let pendingPromise = Promise<UIImage>.pending()
        
        self.fetch(url) { (result) in
            switch result {
            case .success(let image):
                pendingPromise.resolver.resolve(Result<UIImage>.fulfilled(image))
            case .failure(let error):
                pendingPromise.resolver.reject(error)
            }
        }
        
        return pendingPromise.promise
    }
    
    func fetch(_ url: URL) -> Promise<UIImage> {
        let pendingPromise = Promise<UIImage>.pending()
        
        self.fetch(url) { (result) in
            switch result {
            case .success(let image):
                pendingPromise.resolver.resolve(Result<UIImage>.fulfilled(image))
            case .failure(let error):
                pendingPromise.resolver.reject(error)
            }
        }
        
        return pendingPromise.promise
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
