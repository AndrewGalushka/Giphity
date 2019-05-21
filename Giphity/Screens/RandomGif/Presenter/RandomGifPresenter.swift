//
//  RandomGifPresentor.swift
//  Giphity
//
//  Created by Galushka on 4/19/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit
import PromiseKit

class RandomGifPresenter: RandomGifViewPresenter {
    
    // MARK: - Properties(Private)
    
    private let randomGifService: RandomGifServiceType
    private var isViewShown: Bool = false
    
    // MARK: - Properties(Public)
    
    weak var view: RandomGifView?
    
    // MARK: - Initializers
    
    init(randomGifService: RandomGifServiceType) {
        self.randomGifService = randomGifService
    }

    // MARK: - RandomGifViewPresenter Imp
    
    func viewWillAppear() {
        
        if !isViewShown {
            isViewShown = true
            fetchAndDisplayRandomGif()
        }
    }
    
    func viewLoaded() {
    }
    
    func nextRandomGif() {
        fetchAndDisplayRandomGif()
    }
    
    // MARK: - Methods(Private)
    
    private func fetchAndDisplayRandomGif() {
        PromiseKit.firstly { () -> Promise<UIImage> in
            self.view?.showLoadingIndicator()
            return randomGifService.randomGif(ofSize: ImageObject.ImageType.downsized)
            }.done { (image) in
                self.view?.displayGif(image)
            }.catch { (error) in
                self.view?.displayRandomGifError(error)
            }.finally {
                self.view?.hideLoadingIndicator()
        }
    }
}
