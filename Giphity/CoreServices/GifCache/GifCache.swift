//
//  GifCache.swift
//  Giphity
//
//  Created by Galushka on 4/26/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

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

