//
//  TrendingGIFsView.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol TrendingGIFsView: AnyObject {
    func displaySearchResults(_ searchResults: [TrendingGIFCollectionViewCell.ViewModel])
    func displayNextBatchOfResults(_ searchResults: [TrendingGIFCollectionViewCell.ViewModel])
}
