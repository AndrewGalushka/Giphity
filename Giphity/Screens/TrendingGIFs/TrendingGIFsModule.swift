//
//  TrendingGIFsModule.swift
//  Giphity
//
//  Created by Galushka on 5/17/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import UIKit

class TrendingGIFsModule: ViewControllerModule {
    let presenter: TrendingGIFsPresenter
    let trendingGIFsView: TrendingGIFsViewController
    
    weak var moduleOutput: TrendingGIFsModuleOutput?
    
    init(view: TrendingGIFsViewController, presenter: TrendingGIFsPresenter) {
        self.trendingGIFsView = view
        self.presenter = presenter
        
        self.trendingGIFsView.presenter = presenter
        self.presenter.view = view
    }
    
    var asViewController: UIViewController {
        return trendingGIFsView
    }
}

extension TrendingGIFsModule: TrendingGIFsPresenterOutput {
    func trendingGIFsPresenter(_ presenter: TrendingGIFsPresenter, gifSelectedWithID gifID: String) {
        self.moduleOutput?.trendingGIFsModule(self, didSelectGIFWithID: gifID)
    }
}
