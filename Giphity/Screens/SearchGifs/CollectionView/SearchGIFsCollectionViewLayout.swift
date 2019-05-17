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
        
        self.recalculateIndents(for: collectionView)
        self.recalculateItemSize(for: collectionView)
    }
    
    private func recalculateIndents(for collectionView: UICollectionView) {
        self.minimumInteritemSpacing = 5.0
        self.minimumLineSpacing = 5.0
        
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing,
                                         left: self.minimumInteritemSpacing,
                                         bottom: self.minimumInteritemSpacing,
                                         right: self.minimumInteritemSpacing)
    }
    
    private func recalculateItemSize(for collectionView: UICollectionView) {
        let numberOfItemsInRow = 2
        let sideSize = (collectionView.bounds.inset(by: collectionView.layoutMargins).width / CGFloat(numberOfItemsInRow)).rounded(.down)
        
        self.itemSize = CGSize(width: sideSize,
                               height: sideSize)
    }
}
