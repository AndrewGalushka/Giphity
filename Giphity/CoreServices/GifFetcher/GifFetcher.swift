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

enum GifFetcherError: Error {
    case coundNotConvertDataToGif
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .coundNotConvertDataToGif:
            return "Could not convert data to gif"
        case .unknown:
            return "Unknown error"
        }
    }
}

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
        
        Alamofire.request(url, method: .get).responseData { [weak self] (dataResponse) in
            guard let `self` = self else { return }
            
            if let error = dataResponse.error {
                competion(.failure(error))
            } else if let data = dataResponse.data {
                
                if let gifImage = self.gifEngine.gifImage(from: data) {
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
