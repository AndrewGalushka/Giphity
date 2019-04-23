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
    
    typealias GifCollectionViewCellConfigurator = CollectionViewCellConfigurator<GifCollectionViewCell.ViewModel, GifCollectionViewCell>
    var collectionViewDataSource: CollectionViewDataSource<GifCollectionViewCellConfigurator>!
    
    weak var presenter: SearchGifsViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        let configurator = GifCollectionViewCellConfigurator { (cell, viewModel, collectionView, indexPath) -> GifCollectionViewCell in
            cell.configure(viewModel)
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
        let value: CGFloat = 5.0
        let minimumInteritemSpacing: CGFloat = value
        let minimumLineSpacing: CGFloat = value
        let sideSize = (self.collectionView.bounds.width * 0.5)//.rounded()
        let itemSize = CGSize(width: sideSize - minimumInteritemSpacing,
                              height: sideSize - minimumLineSpacing)
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        collectionViewLayout.minimumInteritemSpacing = minimumInteritemSpacing
        collectionViewLayout.minimumLineSpacing = minimumLineSpacing
        collectionViewLayout.itemSize = itemSize
        self.collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
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
}

extension SearchGifsViewController: SearchGIFsView {
    
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
        let section = Section<GifCollectionViewCell.ViewModel>.init(items: searchResults)
        
        self.collectionViewDataSource.dataSource.sections = [section]
        self.collectionView.reloadData()
    }
    
    func displaySearchFailed(error: Error) {
        print(error)
        self.collectionViewDataSource.dataSource.sections.removeAll()
        self.collectionView.reloadData()
    }
}
