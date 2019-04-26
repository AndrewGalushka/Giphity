//
//  CollectionViewDataSource.swift
//  Giphity
//
//  Created by Galushka on 4/10/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class CollectionViewDataSource<Configurator: CollectionViewCellConfiguratorType>: NSObject, UICollectionViewDataSource {
    var dataSource: DataSource<Configurator.Item>
    var configurator: Configurator
    
    func registerCells(in colletionView: UICollectionView) {
        configurator.registerCells(in: colletionView)
    }
    
    init(dataSource: DataSource<Configurator.Item>, configurator: Configurator) {
        self.dataSource = dataSource
        self.configurator = configurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfItems(in: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource.item(at: indexPath)
        return self.configurator.configuredCell(for: item, collectionView: collectionView, indexPath: indexPath)
    }
}
