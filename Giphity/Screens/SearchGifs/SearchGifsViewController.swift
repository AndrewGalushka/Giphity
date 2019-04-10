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
    
    let giphyRequestManager = GiphyRequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
    }
    
    func setupCollectionView() {
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
}

extension SearchGifsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let text = searchBar.text, !text.isEmpty {
            
            giphyRequestManager.searchGifs(name: text) { (response) in
                
                switch response {
                case .success(let searchResult):
                    print(searchResult)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
