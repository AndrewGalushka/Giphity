//
//  PaginationController.swift
//  Giphity
//
//  Created by Galushka on 5/23/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import PromiseKit

protocol PaginationType {
    var offset: Int { get }
    var totalCount: Int { get }
    var count: Int { get }
}

extension GiphyPagination: PaginationType {}

class PaginationController {
    var limit: UInt = UInt(15)
    private(set) var identifier: String?
    private(set) var pagination: PaginationType?
    private(set) var isFetchingInProgress: Bool = false
    
    func firstExecution<T>(sessionID: String, task: Promise<T>) -> Promise<Promise<T>> {
        self.reset()
        self.identifier = sessionID
        self.isFetchingInProgress = true
        
        return Promise<Promise<T>>.init(resolver: { (resolver) in
            
            _ = task.ensure {
                self.isFetchingInProgress = false
                
                guard
                    let currentIdentifier = self.identifier,
                    sessionID == currentIdentifier
                else {
                    resolver.reject(FirstExecutionError.identifierExpired)
                    return
                }
                
                resolver.fulfill(task)
            }
        })
    }
    
    func nextExecution<T>(task: () -> Promise<T>) -> Promise<Promise<T>> {
        guard
            let identifierAtMomementOfExectionStart = self.identifier,
            let pagination = pagination
        else {
            return Promise.init(error: NextExecutuinError.nextExecutionCalledBeforeFirst)
        }
        
        let offset = pagination.offset + pagination.count
        guard offset < pagination.totalCount else {
            return Promise.init(error: NextExecutuinError.endOfList)
        }
        
        let (resultPromise, resolver) = Promise<Promise<T>>.pending()
        
        let taskPromise = task()
        
        _ = taskPromise.ensure {
            self.isFetchingInProgress = false
            
            guard
                let currentIdentifier = self.identifier,
                identifierAtMomementOfExectionStart == currentIdentifier
            else {
                resolver.reject(NextExecutuinError.identifierExpired)
                return
            }
            
            resolver.fulfill(taskPromise)
        }
        
        return resultPromise
    }
    
    func reset() {
        self.identifier = nil
        self.pagination = nil
        self.isFetchingInProgress = false
    }
    
    func savePagination(_ pagination: PaginationType) {
        self.pagination = pagination
    }
}

extension PaginationController {
    
    enum FirstExecutionError: Error {
        case identifierExpired
    }
    
    enum NextExecutuinError: Error {
        case nextExecutionCalledBeforeFirst
        case endOfList
        case identifierExpired
    }
}
