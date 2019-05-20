//
//  TrendingGIFCollectionViewCell.swift
//  Giphity
//
//  Created by Galushka on 5/17/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class TrendingGIFCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties(IBOutlet)
    
    @IBOutlet private weak var numberLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.numberLabel.text = nil
    }
    
    private func setupUI() {
        contentView.layer.borderWidth = 4.0
        contentView.layer.borderColor = UIColor.yellow.cgColor
        contentView.backgroundColor = UIColor.lightGray
        numberLabel.textColor = .rgba(255, 255, 0)
    }
    
    func configure(number: Int) {
        self.numberLabel.text = "\(number)"
    }
}
