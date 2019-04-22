//
//  RandomGifModule.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class RandomGifModule: ViewControllerModule {
    let presentor: RandomGifPresenter
    let randomGifView: RandomGifViewController
    
    init(view: RandomGifViewController, presentor: RandomGifPresenter) {
        self.randomGifView = view
        self.presentor = presentor
        
        randomGifView.presentor = presentor
        presentor.view = randomGifView
    }
    
    var asViewController: UIViewController {
        return randomGifView
    }
}
