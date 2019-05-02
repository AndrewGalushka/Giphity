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
    func fetchGIF(by url: URL) -> Promise<UIImage>
    func fetchGIF(by url: URL, shouldUseCache: Bool) -> Promise<UIImage>
    func fetchGIF(by url: URL, downsampledToSize: CGSize, shouldUseCache: Bool) -> Promise<UIImage>
}
