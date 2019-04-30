//
//  GifFetchingServiceType.swift
//  Giphity
//
//  Created by Galushka on 4/25/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol GifPrefetchingServiceType {
    func fetchGif(using url: URL) -> Promise<UIImage>
}
