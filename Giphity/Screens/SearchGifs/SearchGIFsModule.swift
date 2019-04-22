//
//  SearchGIFsModule.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class SearchGIFsModule: ViewControllerModule {
    let presenter: SearchGifsPresenter
    let searchGIFsView: SearchGifsViewController
    
    init(view: SearchGifsViewController, presenter: SearchGifsPresenter) {
        self.searchGIFsView = view
        self.presenter = presenter
        
        searchGIFsView.presenter = presenter
        presenter.view = searchGIFsView
    }
    
    var asViewController: UIViewController {
        return searchGIFsView
    }
}

