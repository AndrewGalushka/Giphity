//
//  trendingGIFsView.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol trendingGIFsView: AnyObject {
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel])
    func displayNextBatchOfResults(_ searchResults: [GifCollectionViewCell.ViewModel])
}
