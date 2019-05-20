//
//  SearchGIFsCollectionViewControllerDelegate.swift
//  Giphity
//
//  Created by Galushka on 5/20/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol SearchGIFsCollectionViewControllerDelegate: AnyObject {
    func searchGIFsCollectionViewControllerNextBatch(_ controller: SearchGIFsCollectionViewController)
    func searchGIFsCollectionViewControllerHideKeyboard(_ controller: SearchGIFsCollectionViewController)
}
