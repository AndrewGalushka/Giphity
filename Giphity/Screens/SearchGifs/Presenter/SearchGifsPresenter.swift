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
    
    weak var view: SearchGIFsView?
    
    // MARK: - Initializers
    
    init(searchService: SearchGIFsPaginationServiceType) {
        self.searchService = searchService
        self.searchService.delegate = self
    }
    
    // MARK: - SearchGifsViewPresenter
    
    func viewLoaded() {
        self.searchGIFs(by: "Cats")
    }
    
    func searchGIFs(by name: String) {
        guard !name.isEmpty else {
            view?.displaySearchResults([])
            return
        }
        
        searchService.searchGIFs(by: name)
    }
    
    func nextBatchOfGIFs() {
        searchService.nextBatch()
    }
    
    private func convertGifObjectsToViewModels(gifObjects: [GifObject],
                                             ofImageType imageObjectType: ImageObject.ImageType = .downsized) -> [GifCollectionViewCell.ViewModel] {
        guard !gifObjects.isEmpty else { return [] }
        
        var viewModels = [GifCollectionViewCell.ViewModel]()
        
        for gifObject in gifObjects {
            guard let url = gifObject.images?.imageObject(for: imageObjectType)?.url else { continue }
            let viewModel = GifCollectionViewCell.ViewModel(identifier: gifObject.identifier, gifURL: url)
            
            viewModels.append(viewModel)
        }
        
        return viewModels
    }
}

extension SearchGifsPresenter: SearchGIFsPaginationServiceDelegate {
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFetchFirstBatch gifObjects: [GifObject]) {
        let viewModels = self.convertGifObjectsToViewModels(gifObjects: gifObjects, ofImageType: .fixedHeight_downsampled)
        self.view?.displaySearchResults(viewModels)
    }
    
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFetchNextBatch gifObjects: [GifObject]) {
        let viewModels = self.convertGifObjectsToViewModels(gifObjects: gifObjects, ofImageType: .fixedHeight_downsampled)
        self.view?.displayNextBatchOfResults(viewModels)
    }
    
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFailToFetchFirstBatch error: Error) {
        self.view?.displaySearchFailed(error: error)
    }
    
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFailToFetchNextBatch error: Error) {
        print("error")
    }
}
