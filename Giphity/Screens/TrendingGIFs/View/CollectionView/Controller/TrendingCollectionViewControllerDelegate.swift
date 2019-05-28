//
//  TrendingCollectionViewControllerDelegate.swift
//  Giphity
//
//  Created by Galushka on 5/20/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol TrendingGIFsCollectionViewControllerDelegate: AnyObject {
    func trendingCollectionViewControllerNextBatch(_ controller: TrendingGIFsCollectionViewController)
    func trendingCollectionView(_ controller: TrendingGIFsCollectionViewController, didSelectItem: TrendingGIFCollectionViewCell.ViewModel)
}
