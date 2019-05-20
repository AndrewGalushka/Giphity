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
        self.view.backgroundColor = .rgba(240, 248, 255)
        self.view.layer.cornerRadius = 10.0
        
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = UIColor(red:0.0, green:1.0, blue:0.0, alpha:1.0)
        let layout = TrendingGIFsCollectionViewLayout()
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self
        
        collectionView.register( UINib(nibName: "\(TrendingGIFCollectionViewCell.self)", bundle: nil) , forCellWithReuseIdentifier: "\(TrendingGIFCollectionViewCell.self)")
    }
}

extension TrendingGIFsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TrendingGIFCollectionViewCell.self)", for: indexPath) as! TrendingGIFCollectionViewCell
        cell.configure(number: indexPath.row)
        
        return cell
    }
}

extension TrendingGIFsViewController: TrendingGIFsView {
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
    }
    
    func displayNextBatchOfResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
    }
}
