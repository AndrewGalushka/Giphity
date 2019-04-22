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
    private let randomGifService: RandomGifServiceType
    
    weak var view: RandomGifView?
    
    init(randomGifService: RandomGifServiceType) {
        self.randomGifService = randomGifService
    }

    // MARK: - RandomGifPresentorInput
    
    func viewLoaded() {
        PromiseKit.firstly { () -> Promise<UIImage> in
            self.view?.showLoadingIndicator()
            return randomGifService.randomGif()
        }.done { (image) in
            self.view?.displayGif(image)
        }.catch { (error) in
            print(error)
        }.finally {
            self.view?.hideLoadingIndicator()
        }
    }
    
    func nextRandomGif() {
        PromiseKit.firstly { () -> Promise<UIImage> in
            self.view?.showLoadingIndicator()
            return randomGifService.randomGif()
            }.done { (image) in
                self.view?.displayGif(image)
            }.catch { (error) in
                print(error)
            }.finally {
                self.view?.hideLoadingIndicator()
        }
    }
}
