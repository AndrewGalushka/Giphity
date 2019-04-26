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
        
        self.contentView.backgroundColor = UIColor.rgba(244, 255, 250)
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.clipsToBounds = true
    }
    
    func configure(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func displayGif() {
        guard let viewModel = self.viewModel else { return }
        
        let fetchingGifID = viewModel.identifier
        
        var fetchingTimeLogger = TimeSpentLogger()
        fetchingTimeLogger.start()
        
        self.gifFetcher.fetch(viewModel.gifURL) { [weak self] (response) in
            
            fetchingTimeLogger.end(textBeforeTimeLog: "Gif fetching time is")
            
            guard
                let currentViewModel = self?.viewModel,
                currentViewModel.identifier == fetchingGifID
            else { return }
            
            var imageSettingTimeLogger = TimeSpentLogger()
            imageSettingTimeLogger.start()
            
            DispatchQueue.main.async {
                switch response {
                case .success(let gif):
                    self?.imageView.image = gif
                case .failure(_):
                    self?.imageView.image = nil
                }
                
                imageSettingTimeLogger.end(textBeforeTimeLog: "Time spent to set image is")
            }
        }
    }
}

extension GifCollectionViewCell: InterfaceBuilderIdentifiable {}
