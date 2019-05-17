//
//  TrandingGIFsViewController.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class TrandingGIFsViewController: UIViewController {

    // MARK: - Properties(Public)
    
    weak var presenter: TrandingGIFsViewPresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .rgba(200, 200, 200)
        self.view.layer.cornerRadius = 10.0
    }
}

extension TrandingGIFsViewController: TrandingGIFsView {
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
    }
    
    func displayNextBatchOfResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
    }
}
