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
    weak var delegate: TrendingGIFsCollectionViewControllerDelegate?
    
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
    
    func displaySearchResults(_ trendingGIFViewModels: [TrendingGIFCollectionViewCell.ViewModel]) {
        let section = Section<TrendingGIFCollectionViewCell.ViewModel>(items: trendingGIFViewModels)
        collectionViewDataSource.dataSource.sections = [section]
        self.collectionView.reloadData()
    }
    
    func displayNextBatchOfResults(_ searchResults: [TrendingGIFCollectionViewCell.ViewModel]) {
        guard let oldSection = collectionViewDataSource.dataSource.sections.first else { return }
        let updatedSection = Section(items: oldSection.items + searchResults)
        
        
        collectionViewDataSource.dataSource.sections[0] = updatedSection

        let itemsCountInOldSection = oldSection.items.count
        let itemsCountInUpdatedSection = updatedSection.items.count

        var insertedIndexes = [IndexPath]()

        for row in itemsCountInOldSection..<itemsCountInUpdatedSection {
            insertedIndexes.append(IndexPath(row: row, section: 0))
        }

        collectionView.performBatchUpdates({
            collectionView.insertItems(at: insertedIndexes)
        }, completion: { (finished) in })
    }
    
    func removeAllItems() {
        self.collectionViewDataSource.dataSource.sections.removeAll()
        self.collectionView.reloadData()
    }
}

extension TrendingGIFsCollectionViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)  {
        let percentThreshold: CGFloat = 0.9
        
        let scrollViewContentHeight = scrollView.contentSize.height
        let threshold = scrollViewContentHeight * percentThreshold
        
        if (targetContentOffset.pointee.y + scrollView.bounds.height) >= threshold {
            self.delegate?.trendingCollectionViewControllerNextBatch(self)
        }
    }
}

// MARK: - Factory

extension TrendingGIFsCollectionViewController {
    private typealias TrendingGIFsCellConfigurator = CollectionViewCellConfigurator<TrendingGIFCollectionViewCell.ViewModel, TrendingGIFCollectionViewCell>
    
    private func makeCollectionViewDataSource() -> CollectionViewDataSource<TrendingGIFsCellConfigurator> {
        let configurator = self.makeTrendingGIFsCellConfigurator()
        
        let collectionViewDataSource = CollectionViewDataSource<TrendingGIFsCellConfigurator>(dataSource: DataSource<TrendingGIFCollectionViewCell.ViewModel>(),
                                                                                              configurator: configurator)
        
        return collectionViewDataSource
    }
    
    private func makeTrendingGIFsCellConfigurator() -> TrendingGIFsCellConfigurator {
        let configurator = TrendingGIFsCellConfigurator { (cell, trendingGIFVM, collectionView, indexPath) -> TrendingGIFCollectionViewCell in
            cell.configure(trendingGIFVM)
            cell.gifFetcher = self.gifFetchingService
            cell.displayGIF()
            
            return cell
        }
        
        return configurator
    }
}

