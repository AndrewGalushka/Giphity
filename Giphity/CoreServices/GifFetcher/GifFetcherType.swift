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
    func fetch(_ url: String) -> Promise<UIImage>
    func fetch(_ url: URL) -> Promise<UIImage>
    func fetch(_ gifObject: GifObject) -> Promise<UIImage>
    func fetch(_ gifObject: GifObject, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void)
    func fetch(_ url: String, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void)
    func fetch(_ url: URL, competion: @escaping (_: Swift.Result<UIImage, Error>) -> Void)
}
