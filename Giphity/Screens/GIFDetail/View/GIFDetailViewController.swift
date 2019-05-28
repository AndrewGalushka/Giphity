//
//  GIFDetailViewController.swift
//  Giphity
//
//  Created by Galushka on 5/27/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class GIFDetailViewController: UIViewController, GIFDetailView {

    weak var presenter: GIFDetailViewPresenter?
    private let gradient: CAGradientLayer =  CAGradientLayer()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = self.view.bounds
    }
    
    private func configureGradient() {
        gradient.colors = [UIColor.blue, UIColor.green, UIColor.red]
        self.view.layer.addSublayer(gradient)
        gradient.frame = self.view.bounds
    }
}
