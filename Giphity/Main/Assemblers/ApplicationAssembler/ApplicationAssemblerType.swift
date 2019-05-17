//
//  ApplicationAssemblerType.swift
//  Giphity
//
//  Created by Galushka on 4/19/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol ApplicationAssemblerType {
    func assembleGiphyRequestManager() -> GiphyRequestManager
    func assembleGifDataEngineType() -> GifDataEngineType
    func assembleGifFetcher() -> GifFetcherType
}
