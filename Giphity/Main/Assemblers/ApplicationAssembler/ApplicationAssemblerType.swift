//
//  ApplicationAssemblerType.swift
//  Giphity
//
//  Created by Galushka on 4/19/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol ApplicationAssemblerType {
    func assemblyGiphyRequestManager() -> GiphyRequestManager
    func assemblyGifDataEngineType() -> GifDataEngineType
    func assemblyGifFetcher() -> GifFetcherType
}
