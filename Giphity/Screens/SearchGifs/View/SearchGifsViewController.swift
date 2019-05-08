//
//  SearchGifsViewController.swift
//  Giphity
//
//  Created by Galushka on 4/5/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class SearchGifsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    let gifFetchingService: GifPrefetchingServiceType = GifPrefetchingService()
    
    typealias GifCollectionViewCellConfigurator = CollectionViewCellConfigurator<GifCollectionViewCell.ViewModel, GifCollectionViewCell>
    var collectionViewDataSource: CollectionViewDataSource<GifCollectionViewCellConfigurator>!
    
    weak var presenter: SearchGifsViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
        setupCollectionViewLayout()
        
        self.presenter?.viewLoaded()
    }
    
    func setupCollectionView() {
        
        let configurator = GifCollectionViewCellConfigurator { (cell, viewModel, collectionView, indexPath) -> GifCollectionViewCell in
            cell.configure(viewModel)
            cell.gifFetcher = self.gifFetchingService
            cell.displayGif()
            
            return cell
        }
        
        collectionViewDataSource = CollectionViewDataSource(dataSource: DataSource<GifCollectionViewCell.ViewModel>(), configurator: configurator)
        
        collectionView.delegate = self
        collectionView.dataSource = collectionViewDataSource
        collectionViewDataSource.registerCells(in: collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        let layout = SearchGIFsCollectionViewLayout()
        self.collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
}

extension SearchGifsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let text = searchBar.text ?? ""
        self.presenter?.searchGIFs(by: text)
    }
}

extension SearchGifsViewController: UICollectionViewDelegateFlowLayout {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let percentThreshold: CGFloat = 0.75
        
        let scrollViewContentHeight = scrollView.contentSize.height
        let threshold = scrollViewContentHeight * percentThreshold
        
        if targetContentOffset.pointee.y >= threshold {
            self.presenter?.nextBatchOfGIFs()
        }
    }
}

extension SearchGifsViewController: SearchGIFsView {
    
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
        let section = Section<GifCollectionViewCell.ViewModel>.init(items: searchResults)
        
        self.collectionViewDataSource.dataSource.sections = [section]
        self.collectionView.reloadData()
    }
    
    func displayNextBatchOfResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
        guard let oldSection = collectionViewDataSource.dataSource.sections.first else { return }
        
        let updatedSection = Section(items: oldSection.items + searchResults)
        collectionViewDataSource.dataSource.sections[0] = updatedSection
    
        let itemsCountInOldSection = oldSection.items.count == 0 ? 0 : (oldSection.items.count - 1)
        let itemsCountInUpdatedSection = updatedSection.items.count == 0 ? 0 : (updatedSection.items.count - 1)
        
        var insertedIndexes = [IndexPath]()
        
        for row in itemsCountInOldSection...itemsCountInUpdatedSection {
            insertedIndexes.append(IndexPath(row: row, section: 0))
        }
        
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: insertedIndexes)
        }, completion: { (finished) in })
    }
    
    func displaySearchFailed(error: Error) {
        print(error)
        self.collectionViewDataSource.dataSource.sections.removeAll()
        self.collectionView.reloadData()
    }
}
