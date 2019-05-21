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
    
    func trendingGIFs() {
        self.trendingGIFsService.trendingGIFs().done { (response) in
            let viewModels = self.convertToCollectionViewModels(response: response)
            self.view?.displaySearchResults(viewModels)
        }.catch { (error) in
            self.view?.displaySearchResults([])
        }
    }
    
    func nextBatchOfGIFs() {
    }
    
    // MARK: - Methods(Private)
    
    private func convertToCollectionViewModels(response: GiphySearchResponse) -> [TrendingGIFCollectionViewCell.ViewModel] {
        let viewModels = self.searchResponseConvertor.convertToAssociatedImages(response, ofType: .fixedHeight_downsampled).map {
            return TrendingGIFCollectionViewCell.ViewModel(identifier: $0.gifObject.identifier, gifURL: $0.image.url)
        }
        
        return viewModels
    }
}
