//
//  SearchGIFsView.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol SearchGIFsView: AnyObject {
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel])
    func displayNextBatchOfResults(_ searchResults: [GifCollectionViewCell.ViewModel])
    func displaySearchFailed(error: Error)
}
