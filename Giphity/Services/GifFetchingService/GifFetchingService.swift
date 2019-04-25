//
//  GifFetchingService.swift
//  Giphity
//
//  Created by Galushka on 4/25/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

class GifFetchingService: GifFetchingServiceType {
    private let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.gif.fetching.service.queue"
        
        return queue
    }()
    
    func fetchGif(using url: URL) -> Promise<UIImage> {
        let extFetcingTask = self.operationQueue.operations.first { (operation) -> Bool in
            return url.path == operation.name
        }
        
        if let extFetcingTask = extFetcingTask {
            return Promise.init(resolver: { (resolver) in
                DispatchQueue.global(qos: .userInteractive).async {
                    extFetcingTask.waitUntilFinished()
                    
                }
            })
        }
        
        fatalError()
    }
}
