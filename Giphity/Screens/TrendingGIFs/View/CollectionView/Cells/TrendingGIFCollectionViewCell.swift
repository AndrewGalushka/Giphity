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
    
    private var viewModel: ViewModel?
    var gifFetcher: GifPrefetchingServiceType?
    
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
    
    func displayGIF() {
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
    
    // MARK: - Methods(Private)
    
    private func setupUI() {
        contentView.layer.borderWidth = 4.0
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderColor = UIColor.yellow.cgColor
        contentView.backgroundColor = UIColor.lightGray
        contentView.clipsToBounds = true
        
        self.imageView.backgroundColor = .clear
    }
}
