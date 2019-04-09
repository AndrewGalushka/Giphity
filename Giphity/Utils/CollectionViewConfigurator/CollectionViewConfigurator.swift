//
//  CollectionViewConfigurator.swift
//  Giphity
//
//  Created by Galushka on 4/9/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

protocol CollectionViewConfiguratorType {
    associatedtype Item
    associatedtype Cell: UICollectionViewCell
    
    func reuseIdentifier(for item: Item, indexPath: IndexPath) -> String
    func configure(cell: Cell, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> Cell
    func registerCells(in collectionView: UICollectionView)
}

extension CollectionViewConfiguratorType {
    
    func configuretedCell(for item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> Cell {
        let reuseIdentifier = self.reuseIdentifier(for: item, indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Cell
        
        return self.configure(cell: cell, item: item, collectionView: collectionView, indexPath: indexPath)
    }
}
