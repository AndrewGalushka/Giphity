//
//  trendingGIFsModule.swift
//  Giphity
//
//  Created by Galushka on 5/17/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import UIKit

class trendingGIFsModule: ViewControllerModule {
    let presenter: trendingGIFsPresenter
    let trendingGIFsView: trendingGIFsViewController
    
    init(view: trendingGIFsViewController, presenter: trendingGIFsPresenter) {
        self.trendingGIFsView = view
        self.presenter = presenter
        
        self.trendingGIFsView.presenter = presenter
        self.presenter.view = view
    }
    
    var asViewController: UIViewController {
        return trendingGIFsView
    }
}
