//
//  SearchGifsPresenter.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

class SearchGifsPresenter: SearchGifsViewPresenter {
    private let searchService: SearchGIFsPaginationServiceType
    private let searchResponseConvertor: GiphySearchResponseConvertorType = GiphySearchResponseConvertor()
    
    weak var view: SearchGIFsView?
    
    // MARK: - Initializers
    
    init(searchService: SearchGIFsPaginationServiceType) {
        self.searchService = searchService
        self.searchService.delegate = self
    }
    
    // MARK: - SearchGifsViewPresenter
    
    func viewLoaded() {
    }
    
    func searchGIFs(by name: String) {
        guard !name.isEmpty else {
            view?.displaySearchResults([])
            return
        }
        
        searchService.searchGIFs(by: name)
    }
    
    func nextBatchOfGIFs() {
        
        if !self.searchService.isFetchingInProcess {
            searchService.nextBatch()
        }
    }
    
    private func convertGifObjectsToViewModels(gifObjects: [GifObject],
                                             ofImageType imageObjectType: ImageObject.ImageType = .fixedHeight_downsampled) -> [GifCollectionViewCell.ViewModel] {

        let viewModels = searchResponseConvertor.convertToAssociatedImages(gifObjects, ofType: imageObjectType).map {
            return GifCollectionViewCell.ViewModel(identifier: $0.gifObject.identifier, gifURL: $0.image.url)
        }
        
        return viewModels
    }
}

extension SearchGifsPresenter: SearchGIFsPaginationServiceDelegate {
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFetchFirstBatch gifObjects: [GifObject]) {
        let viewModels = self.convertGifObjectsToViewModels(gifObjects: gifObjects)
        self.view?.displaySearchResults(viewModels)
    }
    
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFetchNextBatch gifObjects: [GifObject]) {
        let viewModels = self.convertGifObjectsToViewModels(gifObjects: gifObjects)
        self.view?.displayNextBatchOfResults(viewModels)
    }
    
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFailToFetchFirstBatch error: Error) {
        self.view?.displaySearchFailed(error: error)
    }
    
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFailToFetchNextBatch error: Error) {
        print(error.localizedDescription)
    }
}
