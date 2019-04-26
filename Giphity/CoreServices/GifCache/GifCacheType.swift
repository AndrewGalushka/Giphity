//
//  GifCacheType.swift
//  Giphity
//
//  Created by Galushka on 4/26/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol GifCacheType {
    func save(gifData data: Data, downloadedUsing url: URL)
    func gifData(downloadedUsing url: URL) -> Data?
    
    func save(gifData data: Data, downloadedUsing url: String)
    func gifData(downloadedUsing url: String) -> Data?
}
