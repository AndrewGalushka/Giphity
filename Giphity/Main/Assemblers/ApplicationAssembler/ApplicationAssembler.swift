//
//  ApplicationAssembler.swift
//  Giphity
//
//  Created by Galushka on 4/19/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

class ApplicationAssembler: ApplicationAssemblerType {
    
    // MARK: - Properites(Private)
    
    private let giphyRequestManager: GiphyRequestManager
    private let gifDataEngine: GifDataEngineType
    private let gifFetcher: GifFetcherType
    
    // MARK: - Initializers
    
    init() {
        self.giphyRequestManager = GiphyRequestManager()
        self.gifDataEngine = GifDataEngine()
        self.gifFetcher = GifFetcher()
    }
    
    init(giphyRequestManager: GiphyRequestManager,
         gifDataEngine: GifDataEngineType,
         gifFetcher: GifFetcherType) {
        self.giphyRequestManager = giphyRequestManager
        self.gifDataEngine = gifDataEngine
        self.gifFetcher = gifFetcher
    }
    
    // MARK: - ApplicationAssemblerType
    
    func assembleGiphyRequestManager() -> GiphyRequestManager {
        return self.giphyRequestManager
    }
    
    func assembleGifDataEngineType() -> GifDataEngineType {
        return self.gifDataEngine
    }
    
    func assembleGifFetcher() -> GifFetcherType {
        return self.gifFetcher
    }
}
