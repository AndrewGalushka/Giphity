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
    private lazy var dataSource = self.makeCollectionViewDataSource()
    
    // MARK: - Properties(Public)
    
    let collectionView: UICollectionView
    weak var delegate: SearchGIFsCollectionViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    // MARK: - Methods(Public)
    
    func configure() {
        self.collectionView.dataSource = self.dataSource
        self.collectionView.delegate = self
        dataSource.registerCells(in: self.collectionView)
    }
}

extension SearchGIFsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.delegate?.hideKeyboard()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let percentThreshold: CGFloat = 0.75
        
        let scrollViewContentHeight = scrollView.contentSize.height
        let threshold = scrollViewContentHeight * percentThreshold
        
        if (targetContentOffset.pointee.y + scrollView.bounds.height) >= threshold {
            self.delegate?.nextBatch()
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
