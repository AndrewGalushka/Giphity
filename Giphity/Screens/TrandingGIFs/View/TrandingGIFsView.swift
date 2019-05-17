//
//  TrandingGIFsView.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol TrandingGIFsView: AnyObject {
    func displaySearchResults(_ searchResults: [GifCollectionViewCell.ViewModel])
    func displayNextBatchOfResults(_ searchResults: [GifCollectionViewCell.ViewModel])
}
