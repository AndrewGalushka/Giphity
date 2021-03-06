//
//  GifFetchingService.swift
//  Giphity
//
//  Created by Galushka on 4/25/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

class GifPrefetchingService: GifPrefetchingServiceType {
    
    let gifFetcher: GifFetcherType
    
    init(fetcher: GifFetcherType = GifFetcher(gifDataEngine: GifDataEngine()) ) {
        self.gifFetcher = fetcher
    }
    
    func fetchGif(using url: URL) -> Promise<UIImage> {
        let (promise, resolver) = Promise<UIImage>.pending()
        
        self.pendingTask(for: url).done { [weak self] (fetchingTask) in
            guard let strongSelf = self else { return }
            
            if let fetchingTask = fetchingTask {
                fetchingTask.done {
                    resolver.fulfill($0)
                }.catch {
                    resolver.reject($0)
                }
                
                return
            } else {
                let fetchingTask = strongSelf.gifFetcher.fetchGIF(by: url)
                
                strongSelf.addPendingTask(url: url, task: fetchingTask)
                strongSelf.removePendingTask(at: url, afterCompetionOf: fetchingTask)
                
                fetchingTask.done {
                    resolver.fulfill($0)
                }.catch {
                    resolver.reject($0)
                }
            }
        }
        
        return promise
    }
    
    // MARK: - Pending Tasks

    private var pendingTasks = [URL: Promise<UIImage>]()
    
    private let pendingTasksReadWriteQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    @discardableResult private func addPendingTask(url: URL, task: Promise<UIImage>) -> Guarantee<()> {
        return Guarantee<Void>.init(resolver: { (resolver) in
            pendingTasksReadWriteQueue.addOperation {
                self.pendingTasks[url] = task
                resolver(())
            }
        })
    }
    
    private func removePendingTask(at url: URL, afterCompetionOf task: Promise<UIImage>) {
        _ = task.ensure { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.removePendingTask(for: url)
        }
    }
    
    @discardableResult private func removePendingTask(for url: URL) -> Guarantee<()> {
        return Guarantee<Void>.init(resolver: { (resolver) in
            pendingTasksReadWriteQueue.addOperation {
                self.pendingTasks[url] = nil
                resolver(())
            }
        })
    }
    
    private func pendingTask(for url: URL) -> Guarantee<Promise<UIImage>?> {
        return Guarantee<Promise<UIImage>?>.init(resolver: { (resolver) in
            pendingTasksReadWriteQueue.addOperation {
                let pendingTask = self.pendingTasks[url]
                resolver(pendingTask)
            }
        })
    }
}
