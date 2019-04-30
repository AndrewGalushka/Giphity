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
    var gifFetcher: GifPrefetchingServiceType?
    
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
        self.contentView.layer.borderColor = UIColor.orange.withAlphaComponent(0.5).cgColor
        self.contentView.layer.borderWidth = 1.0
    }
    
    func configure(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func displayGif() {
        guard let viewModel = self.viewModel else { return }
        
        let fetchingGifID = viewModel.identifier
        
        var fetchingTimeLogger = TimeSpentLogger()
        fetchingTimeLogger.start()
        
        self.gifFetcher?.fetchGif(using: URL(string: viewModel.gifURL)! ).done { [weak self] (image) in
            guard fetchingGifID == self?.viewModel?.identifier else { return }
            self?.imageView.image = image
        }.catch { [weak self] (error) in
            guard fetchingGifID == self?.viewModel?.identifier else { return }
            self?.imageView.image = nil
        }.finally {
            fetchingTimeLogger.finish(textBeforeTimeLog: "Gif fetching time is")
        }
    }
}

extension GifCollectionViewCell: InterfaceBuilderIdentifiable {}
