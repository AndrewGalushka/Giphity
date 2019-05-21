//
//  RandomGifModule.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class RandomGifModule: ViewControllerModule {
    let presenter: RandomGifPresenter
    let randomGifView: RandomGifViewController
    
    init(view: RandomGifViewController, presenter: RandomGifPresenter) {
        self.randomGifView = view
        self.presenter = presenter
        
        randomGifView.presenter = presenter
        presenter.view = randomGifView
    }
    
    var asViewController: UIViewController {
        return randomGifView
    }
}
