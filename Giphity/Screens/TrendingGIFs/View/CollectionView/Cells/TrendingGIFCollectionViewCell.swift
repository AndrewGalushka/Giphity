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
    
    // MARK: - Properties(Private)
    
    var viewModel: ViewModel?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        self.numberLabel.text = nil
    }
    
    // MARK: - Methods(Public)
    
    func configure(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        self.numberLabel.text = viewModel.identifier
    }
    
    // MARK: - Methods(Private)
    
    private func setupUI() {
        contentView.layer.borderWidth = 4.0
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderColor = UIColor.yellow.cgColor
        contentView.backgroundColor = UIColor.lightGray
        numberLabel.textColor = .rgba(255, 255, 0)
    }
}