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
    let giphyRequestManager = GiphyRequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    func setupCollectionView() {
        
        let configurator = GifCollectionViewCellConfigurator { (cell, viewModel, collectionView, indexPath) -> GifCollectionViewCell in
            cell.configure(viewModel)
            return cell
        }
        
        collectionViewDataSource = CollectionViewDataSource(dataSource: DataSource<GifCollectionViewCell.ViewModel>(), configurator: configurator)
        
        collectionView.delegate = self
        collectionView.dataSource = collectionViewDataSource
        collectionViewDataSource.registerCells(in: collectionView)
    }
    
    func setupCollectionViewLayout() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0.0
        collectionViewLayout.minimumLineSpacing = 0.0
        collectionViewLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.width)
        
        self.collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
}

extension SearchGifsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let text = searchBar.text, !text.isEmpty {
            
            giphyRequestManager.searchGifs(name: text) { [weak self] (response) in
                
                switch response {
                case .success(let searchResult):
                    self?.updateCollectionView(searchResult: searchResult)
                case .failure(let error):
                    self?.updateCollectionView(searchResult: nil)
                    print(error)
                }
            }
        }
    }
    
    func updateCollectionView(searchResult: GiphySearchResponse?) {
        
        DispatchQueue.main.async {
            guard let gifObjects = searchResult?.gifObjects else {
                self.collectionViewDataSource.dataSource.sections.removeAll()
                self.collectionView.reloadData()
                return
            }
            
            var gifCellViewModels = [GifCollectionViewCell.ViewModel]()
            
            for gifObject in gifObjects where gifObject.images?.imageObject(for: .downsized) != nil {
                let identifier = gifObject.identifier
                let url: String = (gifObject.images?.imageObject(for: .downsized)?.url)!
                
                gifCellViewModels.append(GifCollectionViewCell.ViewModel(identifier: identifier, gifURL: url))
            }
            
            self.collectionViewDataSource.dataSource.sections = [ Section(items: gifCellViewModels) ]
            self.collectionView.reloadData()
        }
    }
}

extension SearchGifsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let gifCell = cell as? GifCollectionViewCell {
            gifCell.displayGif()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
}
