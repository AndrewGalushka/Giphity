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
    
    private let trendingGIFsService: TrendingGIFsPaginationServiceType
    private let searchResponseConvertor: GiphySearchResponseConvertorType
    
    private var isViewShown: Bool = false
    
    // MARK: - Properties(Public)
    
    weak var view: TrendingGIFsView?

    // MARK: - Initializers

    init(trendingGIFsService: TrendingGIFsPaginationServiceType, responseConvertor: GiphySearchResponseConvertorType = GiphySearchResponseConvertor()) {
        self.trendingGIFsService = trendingGIFsService
        self.searchResponseConvertor = responseConvertor
        
        self.trendingGIFsService.delegate = self
    }
    
    // MARK: - TrendingGIFsViewPresenter Imp
    
    func trendingGIFs() {
        self.trendingGIFsService.firstBatch()
            
//            .done { (response) in
//            let viewModels = self.convertToCollectionViewModels(response: response)
//            self.view?.displaySearchResults(viewModels)
//        }.catch { (error) in
//            self.view?.displaySearchResults([])
//        }
    }
    
    func viewWillAppear() {
        
        if !isViewShown {
            self.isViewShown = true
            trendingGIFs()
        }
    }
    
    func nextBatchOfGIFs() {
        
        if !self.trendingGIFsService.isFetchingInProcess {
            self.trendingGIFsService.nextBatch()
        }
    }
    
    // MARK: - Methods(Private)
    
    private func convertToCollectionViewModels(response: GiphySearchResponse) -> [TrendingGIFCollectionViewCell.ViewModel] {
        let viewModels = self.searchResponseConvertor.convertToAssociatedImages(response, ofType: .fixedHeight_downsampled).map {
            return TrendingGIFCollectionViewCell.ViewModel(identifier: $0.gifObject.identifier, gifURL: $0.image.url)
        }
        
        return viewModels
    }
    
    private func convertGifObjectsToViewModels(gifObjects: [GifObject],
                                               ofImageType imageObjectType: ImageObject.ImageType = .downsized) -> [TrendingGIFCollectionViewCell.ViewModel] {
        
        let viewModels = searchResponseConvertor.convertToAssociatedImages(gifObjects, ofType: imageObjectType).map {
            return TrendingGIFCollectionViewCell.ViewModel(identifier: $0.gifObject.identifier, gifURL: $0.image.url)
        }
        
        return viewModels
    }
}

extension TrendingGIFsPresenter : TrendingGIFsPaginationServiceDelegate {
    func searchGIFsPaginationService(_ service: TrendingGIFsPaginationServiceType, didFetchFirstBatch gifObjects: [GifObject]) {
        let viewModels = self.convertGifObjectsToViewModels(gifObjects: gifObjects, ofImageType: .fixedHeight_downsampled)
        self.view?.displayTrendingGIFsResults(viewModels)
    }
    
    func searchGIFsPaginationService(_ service: TrendingGIFsPaginationServiceType, didFetchNextBatch gifObjects: [GifObject]) {
        let viewModels = self.convertGifObjectsToViewModels(gifObjects: gifObjects, ofImageType: .fixedHeight_downsampled)
        self.view?.displayNextBatchOfResults(viewModels)
    }
    
    func searchGIFsPaginationService(_ service: TrendingGIFsPaginationServiceType, didFailToFetchFirstBatch error: Error) {
        self.view?.displayTrendingGIFsResults([])
    }
    
    func searchGIFsPaginationService(_ service: TrendingGIFsPaginationServiceType, didFailToFetchNextBatch error: Error) {
        print(error.localizedDescription)
    }
    
    
}
