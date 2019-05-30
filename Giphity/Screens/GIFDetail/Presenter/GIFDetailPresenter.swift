//
//  GIFDetailPresenter.swift
//  Giphity
//
//  Created by Galushka on 5/27/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import PromiseKit

class GIFDetailPresenter: GIFDetailViewPresenter {
    
    // MARK: - Properties(Public)
    
    weak var view: GIFDetailView?
    
    // MARK: - Properties(Private)
    
    let singleGIFObjectService: SingleGIFObjectServiceType
    
    // MARK: - Initializers
    
    init(singleGIFObjectService: SingleGIFObjectServiceType) {
        self.singleGIFObjectService = singleGIFObjectService
    }
    
    // MARK: - GIFDetailViewPresenter Imp
    
    func viewLoaded() {
        self.fetchAndDisplayGIF()
    }
    
    func retry() {
        self.retryGIFFetchAndDisplay()
    }
    
    // MARK: - Methods(Private)
    
    private func fetchAndDisplayGIF() {
        
        self.view?.showLoadingGIFIndicator()
        
        self.singleGIFObjectService.gifImage(for: ImageObject.ImageType.downsized_medium).done {
            self.view?.hideLoadingGIFIndicator()
            self.view?.displayGIF($0)
        }.catch {
            self.view?.displayError($0)
        }
    }
    
    private func retryGIFFetchAndDisplay() {
        self.singleGIFObjectService.reload()
        self.fetchAndDisplayGIF()
    }
}
