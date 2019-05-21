//
//  SearchGIFsCollectionViewController.swift
//  Giphity
//
//  Created by Galushka on 5/20/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class SearchGIFsCollectionViewController: NSObject {
    
    // MARK: - Properties(Private)
    
    private let gifFetchingService: GifPrefetchingServiceType = GifPrefetchingService()
    private lazy var collectionViewDataSource = self.makeCollectionViewDataSource()
    private let layout = SearchGIFsCollectionViewLayout()
    
    // MARK: - Properties(Public)
    
    let collectionView: UICollectionView
    weak var delegate: SearchGIFsCollectionViewControllerDelegate?
    
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
    
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
        let section = Section<GifCollectionViewCell.ViewModel>.init(items: searchResults)
        collectionViewDataSource.dataSource.sections = [section]
        self.collectionView.reloadData()
    }
    
    func displayNextBatchOfResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
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

extension SearchGIFsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.delegate?.searchGIFsCollectionViewControllerHideKeyboard(self)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let percentThreshold: CGFloat = 0.9
        
        let scrollViewContentHeight = scrollView.contentSize.height
        let threshold = scrollViewContentHeight * percentThreshold
        
        if (targetContentOffset.pointee.y + scrollView.bounds.height) >= threshold {
            self.delegate?.searchGIFsCollectionViewControllerNextBatch(self)
        }
    }
}

// MARK: - Factory

extension SearchGIFsCollectionViewController {
    private typealias GIFCellConfigurator = CollectionViewCellConfigurator<GifCollectionViewCell.ViewModel, GifCollectionViewCell>
    
    private func makeCollectionViewDataSource() -> CollectionViewDataSource<GIFCellConfigurator> {
        typealias MainViewModel = GifCollectionViewCell.ViewModel
        let mainCellConfigurator = self.makeMainCellConfigurator()
        
        let dataSource = CollectionViewDataSource<GIFCellConfigurator>(dataSource: DataSource<MainViewModel>(), configurator: mainCellConfigurator)
        
        return dataSource
    }
    
    private func makeMainCellConfigurator() -> GIFCellConfigurator {
        return self.makeGIFCellConfigurator()
    }
    
    private func makeGIFCellConfigurator() -> GIFCellConfigurator {
        let configurator = GIFCellConfigurator { (cell, viewModel, collectionView, indexPath) -> GifCollectionViewCell in
            cell.configure(viewModel)
            cell.gifFetcher = self.gifFetchingService
            cell.displayGif()
            
            return cell
        }
        
        return configurator
    }
}
