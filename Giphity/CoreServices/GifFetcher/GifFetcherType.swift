//
//  GifFetcherType.swift
//  Giphity
//
//  Created by Galushka on 4/18/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol GifFetcherType {
    func fetch(_ url: URL) -> Promise<UIImage>
    func fetch(_ url: URL, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void)
    
    func fetch(_ url: String) -> Promise<UIImage>
    func fetch(_ url: String, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void)
}

extension GifFetcherType {
    func fetch(_ urlString: String) -> Promise<UIImage> {
        guard let url = URL(string: urlString) else {
            return Promise<UIImage>(error: GifFetcher.GifFetcherError.unknown)
        }
        
        return self.fetch(url)
    }
    
    func fetch(_ urlString: String, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            competion(.failure(GifFetcher.GifFetcherError.unknown))
            return
        }
        
        return self.fetch(url, competion: competion)
    }
}
