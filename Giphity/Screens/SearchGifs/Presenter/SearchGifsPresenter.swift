//
//  SearchGifsPresenter.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

class SearchGifsPresenter: SearchGifsViewPresenter {
    private let searchService: SearchGIFsServiceType
    
    weak var view: SearchGIFsView?
    
    // MARK: - Initializers
    
    init(searchService: SearchGIFsServiceType) {
        self.searchService = searchService
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
        
        searchService.searchGifs(by: name).done { (response) in
            let viewModels = self.convertResponseToViewModels(response: response, ofImageType: .fixedHeight_downsampled)
            self.view?.displaySearchResults(viewModels)
        }.catch(on: .global()) { (error) in
            self.view?.displaySearchFailed(error: error)
        }
    }
    
    private func convertResponseToViewModels(response: GiphySearchResponse,
                                             ofImageType imageObjectType: ImageObject.ImageType = .downsized) -> [GifCollectionViewCell.ViewModel] {
        guard let gifObjects = response.gifObjects, !gifObjects.isEmpty else { return [] }
        
        var viewModels = [GifCollectionViewCell.ViewModel]()
        
        for gifObject in gifObjects {
            guard let url = gifObject.images?.imageObject(for: imageObjectType)?.url else { continue }
            let viewModel = GifCollectionViewCell.ViewModel(identifier: gifObject.identifier, gifURL: url)
            
            viewModels.append(viewModel)
        }
        
        return viewModels
    }
}
