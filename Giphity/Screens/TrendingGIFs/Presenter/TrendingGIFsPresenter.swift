//
//  TrendingGIFsPresenter.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

class TrendingGIFsPresenter: TrendingGIFsViewPresenter {
    // MARK: - Properties(Private)
    
    private let trendingGIFsService: TrendingGIFsServiceType
    private let searchResponseConvertor: GiphySearchResponseConvertorType
    
    // MARK: - Properties(Public)
    
    weak var view: TrendingGIFsView?

    // MARK: - Initializers

    init(trendingGIFsService: TrendingGIFsServiceType, responseConvertor: GiphySearchResponseConvertorType = GiphySearchResponseConvertor()) {
        self.trendingGIFsService = trendingGIFsService
        self.searchResponseConvertor = responseConvertor
    }
    
    // MARK: - TrendingGIFsViewPresenter Imp
    
    func viewLoaded() {
    }
    
    func trendingGIFs() {
    }
}
