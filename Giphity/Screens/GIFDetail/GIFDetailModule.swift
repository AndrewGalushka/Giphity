//
//  GIFDetailModule.swift
//  Giphity
//
//  Created by Galushka on 5/27/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import UIKit

class GIFDetailModule: ViewControllerModule {
    let presenter: GIFDetailPresenter
    let view: GIFDetailViewController
    
    init(view: GIFDetailViewController, presenter: GIFDetailPresenter) {
        self.view = view
        self.presenter = presenter
        
        view.presenter = presenter
        presenter.view = view
    }
    
    var asViewController: UIViewController {
        return view
    }
}
