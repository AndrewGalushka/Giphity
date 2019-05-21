//
//  TrendingCollectionViewController.swift
//  Giphity
//
//  Created by Galushka on 5/20/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import UIKit

class TrendingGIFsCollectionViewController: NSObject {
    
    // MARK: - Properties(Private)
    
    private let gifFetchingService: GifPrefetchingServiceType = GifPrefetchingService()
    private lazy var collectionViewDataSource = self.makeCollectionViewDataSource()
    private let layout = TrendingGIFsCollectionViewLayout()
    
    // MARK: - Properties(Public)
    
    let collectionView: UICollectionView
    weak var delegate: TrendingCollectionViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    // MARK: - Methods(Public)
    
    func configure(animated isAnimated: Bool = false) {
        self.collectionView.dataSource = self.collectionViewDataSource
        self.collectionView.delegate = self
        collectionViewDataSource.registerCells(in: self.collectionView)
        self.collectionView.setCollectionViewLayout(layout, animated: isAnimated)
    }
}

extension TrendingGIFsCollectionViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)  {
    }
}

// MARK: - Factory

extension TrendingGIFsCollectionViewController {
    private typealias TrendingGIFsCellConfigurator = CollectionViewCellConfigurator<Int, TrendingGIFCollectionViewCell>
    
    private func makeCollectionViewDataSource() -> CollectionViewDataSource<TrendingGIFsCellConfigurator> {
        let dataSource = DataSource(sections: [Section(items: Array(0...40))])
        let configurator = self.makeTrendingGIFsCellConfigurator()
        
        let collectionViewDataSource = CollectionViewDataSource<TrendingGIFsCellConfigurator>(dataSource: dataSource,
                                                                                              configurator: configurator)
        
        return collectionViewDataSource
    }
    
    private func makeTrendingGIFsCellConfigurator() -> TrendingGIFsCellConfigurator {
        let configurator = TrendingGIFsCellConfigurator { (cell, number, collectionView, indexPath) -> TrendingGIFCollectionViewCell in
            let viewModel = TrendingGIFCollectionViewCell.ViewModel(identifier: "\(number)", gifURL: "\(number)")
            cell.configure(viewModel)
            return cell
        }
        
        return configurator
    }
}

