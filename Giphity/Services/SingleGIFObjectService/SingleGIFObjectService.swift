//
//  SingleGIFObjectService.swift
//  Giphity
//
//  Created by Galushka on 5/30/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class SingleGIFObjectService: SingleGIFObjectServiceType {
   
    // MARK: - Properties(Public)
    
    let gifID: String
    
    // MARK: - Properties(Private)
    
    private let gifByIDService: GIFByIDServiceType
    private let gifFetcher: GifFetcherType
    
    private lazy var initialTask: Promise<GifObject> = loadInitialData()
    private var gifObject: GifObject? {
        return initialTask.value
    }
    
    // MARK: - Initializers
    
    init(gifID: String, gifByIDService: GIFByIDServiceType, gifFetcher: GifFetcherType) {
        self.gifID = gifID
        self.gifByIDService = gifByIDService
        self.gifFetcher = gifFetcher
    }
    
    // MARK: - SingleGIFObjectServiceType Imp
    
    func gifImage(for size: ImageObject.ImageType) -> Promise<UIImage> {
        return self.fetchGIF(size: size)
    }
    
    func reload() {
        _ = self.reloadInitialData()
    }
    
    func gifRawData() -> Promise<Data> {
        return fetchGIFRawData(size: .downsized_medium)
    }
    
    // MARK: - Methods(Private)
    
    private func fetchGIF(size: ImageObject.ImageType) -> Promise<UIImage> {
        return firstly {
           return self.initialTask
        }.then { gifObject -> Promise<UIImage> in
           return self.fetchGIF(gifObject: gifObject, size: size)
        }
    }
    
    private func fetchGIF(gifObject: GifObject, size: ImageObject.ImageType) -> Promise<UIImage> {
        guard
            let imageObj = gifObject.images?.imageObject(for: size),
            let url = URL(string: imageObj.url)
        else {
            return Promise.init(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil))
        }
        
        return self.gifFetcher.fetchGIF(by: url)
    }
    
    private func fetchGIFRawData(size: ImageObject.ImageType) -> Promise<Data> {
        return firstly {
            return self.initialTask
        }.then { gifObject -> Promise<Data> in
            return self.fetchGIFRawData(size: size, gifObject: gifObject)
        }
    }
    
    private func fetchGIFRawData(size: ImageObject.ImageType, gifObject: GifObject) -> Promise<Data> {
        
        guard
            let stringURL = gifObject.images?.imageObject(for: size)?.url,
            let url = URL(string: stringURL)
        else {
            return Promise.init(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil))
        }
        
        return Promise<Data>.init { (resolver) in
            
            Alamofire.request(url).responseData(completionHandler: { (dataResponse) in
                resolver.resolve(dataResponse.error, dataResponse.data)
            })
        }
    }
    
    private func loadInitialData() -> Promise<GifObject> {
        
        return Promise<GifObject>.init(resolver: { (resolver) in
            
            gifByIDService.fetchGifObjectByID(self.gifID).done {
                let result = self.validateGIFResponse($0)
                resolver.resolve(result)
            }.catch {
                resolver.reject($0)
            }
        })
    }
    
    private func reloadInitialData() -> Promise<GifObject> {
        self.initialTask = loadInitialData()
        return self.initialTask
    }
    
    private func validateGIFResponse(_ response: GiphyResponse<GifObject>) -> Swift.Result<GifObject, NSError> {
        
        if let gifObject = response.data {
            return .success(gifObject)
        } else {
            let error = NSError(domain: "com.single.gif.object.service", code: response.meta.status, userInfo: ["message": response.meta.msg])
            return .failure(error)
        }
    }
}

