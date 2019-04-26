//
//  GifCache.swift
//  Giphity
//
//  Created by Galushka on 4/26/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

class GifCache {
    private let storage = NSCache<AnyObject, AnyObject>()
    
    func save(_ image: Data, url: URL) {
        storage.setObject(image as NSData, forKey: url.path as AnyObject)
    }
    
    func image(url: URL) -> Data? {
        let gifData = storage.object(forKey: url.path as AnyObject) as? Data
        return gifData
    }
}

