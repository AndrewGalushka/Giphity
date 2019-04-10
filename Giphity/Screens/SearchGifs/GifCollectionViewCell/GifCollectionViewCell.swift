//
//  GifCollectionViewCell.swift
//  Giphity
//
//  Created by Galushka on 4/5/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties(Private)
    
    @IBOutlet private weak var imageView: UIImageView!
    
    private var viewModel: ViewModel?
    private let gifFetcher: GifFetcher = GifFetcher()
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewModel = nil
        self.imageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor.rgba(255, 254, 212)
    }
    
    func configure(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func displayGif() {
        guard let viewModel = self.viewModel else { return }
        
        let fetchingGifID = viewModel.identifier
        
        self.gifFetcher.fetch(viewModel.gifURL) { [weak self] (response) in
            guard
                let currentViewModel = self?.viewModel,
                currentViewModel.identifier == fetchingGifID
            else { return }
            
            DispatchQueue.main.async {
                
                switch response {
                case .success(let gif):
                    self?.imageView.image = gif
                case .failure(_):
                    self?.imageView.image = nil
                }
            }
        }
    }
}

extension GifCollectionViewCell: InterfaceBuilderIdentifiable {}
