//
//  TrendingGIFsCollectionViewLayout.swift
//  Giphity
//
//  Created by Galushka on 5/17/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class TrendingGIFsCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        
        self.recalculateIndents(for: collectionView)
        self.recalculateItemSize(for: collectionView)
    }
    
    private func recalculateIndents(for collectionView: UICollectionView) {
        self.minimumInteritemSpacing = 3.0
        self.minimumLineSpacing = 3.0
        
        self.sectionInset = collectionView.layoutMargins
    }
    
    private func recalculateItemSize(for collectionView: UICollectionView) {
        let numberOfItemsInRow = 2
        
        let numberOfInteritems: Int = (numberOfItemsInRow * 2 - 2) / 2
        let interitemsSpacing = (self.minimumInteritemSpacing * CGFloat(numberOfInteritems)).rounded(.down)
        
        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right - interitemsSpacing
        
        let sideSize = (availableWidth / CGFloat(numberOfItemsInRow)).rounded(.down)
        
        self.itemSize = CGSize(width: sideSize,
                               height: sideSize)
    }
}
