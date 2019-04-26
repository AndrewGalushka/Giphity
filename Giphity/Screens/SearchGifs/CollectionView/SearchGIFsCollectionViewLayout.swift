//
//  SearchGIFsCollectionViewLayout.swift
//  Giphity
//
//  Created by Galushka on 4/26/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class SearchGIFsCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        
        self.recalculateItemSize(for: collectionView)
    }
    
    func recalculateItemSize(for collectionView: UICollectionView) {
    }
}
