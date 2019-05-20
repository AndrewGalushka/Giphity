//
//  MVPModule.swift
//  Giphity
//
//  Created by Galushka on 5/17/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import UIKit

class MVPModule<Presenter: MVPPresenter, View: MVPView> where Presenter.View == View, View.Presenter == Presenter {
    var presenter: Presenter
    var view: View
    
    init(view: View, presenter: Presenter) {
        self.view = view
        self.presenter = presenter
        
        self.view.presenter = self.presenter
        self.presenter.view = self.view
    }
}

extension MVPModule: ViewControllerModule where View: UIViewController {
    var asViewController: UIViewController {
        return view
    }
}

protocol MVPPresenter: AnyObject {
    associatedtype View
    var view: View { get set }
}

protocol MVPView: AnyObject {
    associatedtype Presenter
    var presenter: Presenter { get set }
}
