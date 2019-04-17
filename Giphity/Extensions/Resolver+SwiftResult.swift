//
//  Promise+SwiftResult.swift
//  Giphity
//
//  Created by Galushka on 4/17/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import PromiseKit

extension Resolver {    
    func resolve<E: Error>(_ swiftResult: Swift.Result<T, E>) {
        switch swiftResult {
        case .success(let value):
            self.fulfill(value)
        case .failure(let error):
            self.reject(error)
        }
    }
}
