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
    
    // MARK: - Properties(Private)
    
    private lazy var collectionViewController = TrendingGIFsCollectionViewController(collectionView: collectionView)
    
    // MARK: - Properties(Public)
    
    weak var presenter: TrendingGIFsViewPresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.viewWillAppear()
    }
    
    // MARK: -
    
    func setupUI() {
        self.view.backgroundColor = .rgba(240, 248, 255)
        self.view.layer.cornerRadius = 10.0
        
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionViewController.configure()
        collectionView.backgroundColor = UIColor(red:0.0, green:1.0, blue:0.0, alpha:1.0)
        collectionViewController.delegate = self
    }
}

extension TrendingGIFsViewController: TrendingGIFsCollectionViewControllerDelegate {
    
    func trendingCollectionView(_ controller: TrendingGIFsCollectionViewController,
                                didSelectItem selectedItem: TrendingGIFCollectionViewCell.ViewModel) {
        presenter?.didSelectItem(selectedItem)
    }
    
    
    func trendingCollectionViewControllerNextBatch(_ controller: TrendingGIFsCollectionViewController) {
        self.presenter?.nextBatchOfGIFs()
    }
}

extension TrendingGIFsViewController: TrendingGIFsView {
    func displayTrendingGIFsResults(_ gifVMs: [TrendingGIFCollectionViewCell.ViewModel]) {
        self.collectionViewController.displaySearchResults(gifVMs)
    }
    
    func displayNextBatchOfResults(_ gifVMs: [TrendingGIFCollectionViewCell.ViewModel]) {
        self.collectionViewController.displayNextBatchOfResults(gifVMs)
    }
}
