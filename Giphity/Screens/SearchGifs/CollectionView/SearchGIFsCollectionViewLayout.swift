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
    
    private func recalculateIndents(for collectionView: UICollectionView) {
        self.minimumInteritemSpacing = 5.0
        self.minimumLineSpacing = 5.0
        
//        self.sectionInset = UIEdgeInsets(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
    }
    
    private func recalculateItemSize(for collectionView: UICollectionView) {
        let numberOfItemsInRow = 2
        let sideSize = collectionView.bounds.width / CGFloat(numberOfItemsInRow)
        
        self.itemSize = CGSize(width: sideSize - self.minimumInteritemSpacing,
                               height: sideSize - self.minimumLineSpacing)
    }
}
