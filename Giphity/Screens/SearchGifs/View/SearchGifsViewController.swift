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
    
    private lazy var collectionViewController = SearchGIFsCollectionViewController(collectionView: collectionView)
    
    weak var presenter: SearchGifsViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
        
        self.presenter?.viewLoaded()
    }
    
    func setupCollectionView() {
        collectionViewController.configure()
        collectionViewController.delegate = self
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

extension SearchGifsViewController: SearchGIFsCollectionViewControllerDelegate {
    
    func searchGIFsCollectionViewControllerNextBatch(_ controller: SearchGIFsCollectionViewController) {
        self.presenter?.nextBatchOfGIFs()
    }
    
    func searchGIFsCollectionViewControllerHideKeyboard(_ controller: SearchGIFsCollectionViewController) {
        self.searchBar.resignFirstResponder()
    }
}

extension SearchGifsViewController: SearchGIFsView {
    
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
        self.collectionViewController.displaySearchResults(searchResults)
    }
    
    func displayNextBatchOfResults(_ searchResults: [GifCollectionViewCell.ViewModel]) {
        self.collectionViewController.displayNextBatchOfResults(searchResults)
    }
    
    func displaySearchFailed(error: Error) {
        print(error)
        self.collectionViewController.removeAllItems()
    }
}
