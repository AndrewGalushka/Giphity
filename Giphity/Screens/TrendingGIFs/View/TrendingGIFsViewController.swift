//
//  TrendingGIFsViewController.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class TrendingGIFsViewController: UIViewController {

    // MARK: - Properties(IBOutlet)
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties(Public)
    
    weak var presenter: TrendingGIFsViewPresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .rgba(200, 200, 200)
        self.view.layer.cornerRadius = 10.0
        
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = TrendingGIFsCollectionViewLayout()
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension TrendingGIFsViewController: TrendingGIFsView {
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
    }
    
    func displayNextBatchOfResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
    }
}
