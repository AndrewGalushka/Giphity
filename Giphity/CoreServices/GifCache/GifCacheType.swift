//
//  GifCacheType.swift
//  Giphity
//
//  Created by Galushka on 4/26/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol GifCacheType {
    func save(gifData data: Data, byURL: String)
    func gifData(byURL: String) -> Data?
}

extension GifCacheType {
    func save(gifData data: Data, byURL url: URL) {
        self.save(gifData: data, byURL: url.path)
    }
    
    func gifData(byURL url: URL) -> Data? {
        return self.gifData(byURL: url.path)
    }
}

