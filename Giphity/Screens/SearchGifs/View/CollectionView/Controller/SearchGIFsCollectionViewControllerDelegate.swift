//
//  SearchGIFsCollectionViewControllerDelegate.swift
//  Giphity
//
//  Created by Galushka on 5/20/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol SearchGIFsCollectionViewControllerDelegate: AnyObject {
    func nextBatch()
    func hideKeyboard()
}
