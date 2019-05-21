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
    
    @IBOutlet private weak var imageView: UIImageView!
    
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
        self.imageView.image = nil
    }
    
    // MARK: - Methods(Public)
    
    func configure(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Methods(Private)
    
    private func setupUI() {
        contentView.layer.borderWidth = 4.0
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderColor = UIColor.yellow.cgColor
        contentView.backgroundColor = UIColor.lightGray
        
        self.imageView.backgroundColor = .clear
    }
}
