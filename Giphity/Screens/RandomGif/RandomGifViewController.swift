//
//  ViewController.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit
import PromiseKit

class RandomGifViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextRandomGifButton: UIButton!
    
    let randomGifService: RandomGifServiceType = RandomGifService(gifFetcher: GifFetcher(gifDataEngine: GifDataEngine()), requestManager: GiphyRequestManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.randomGifService.randomGif().done(on: DispatchQueue.main) {
            self.imageView.image = $0
        }.catch(on: DispatchQueue.main) { error in
            self.imageView.image = nil
        }
    }
    
    func setupUI() {
        nextRandomGifButton.setTitle("Next Random Gif", for: .normal)
        nextRandomGifButton.backgroundColor = .orange
        nextRandomGifButton.tintColor = .white
        nextRandomGifButton.layer.cornerRadius = 5.0
        
        nextRandomGifButton.setNeedsLayout()
        nextRandomGifButton.layoutIfNeeded()
        nextRandomGifButton.heightAnchor.constraint(equalToConstant: nextRandomGifButton.bounds.height + 10).isActive = true
        nextRandomGifButton.widthAnchor.constraint(equalToConstant: nextRandomGifButton.bounds.width + 70).isActive = true
    }
    
    @IBAction func nextRandomGifButtonTouchUpInsideActionHandler(_ sender: Any) {
        fetchAndDisplayNextRandomGif()
    }
    
    func fetchAndDisplayNextRandomGif() {
        
        PromiseKit.firstly { () -> Promise<UIImage> in
            self.nextRandomGifButton.isEnabled = false
            return self.randomGifService.randomGif()
        }.done(on: DispatchQueue.main) {
            self.imageView.image = $0
        }.ensure {
            self.nextRandomGifButton.isEnabled = true
        }.catch(on: DispatchQueue.main) { error in
            self.imageView.image = nil
        }
    }
    
    func setLoadingState(for view: UIView) -> (() -> Void) {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        let isUserInteractionEnabledByDefault = view.isUserInteractionEnabled
        
        if isUserInteractionEnabledByDefault {
            view.isUserInteractionEnabled = false
        }
        
        return {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if isUserInteractionEnabledByDefault {
                view.isUserInteractionEnabled = true
            }
        }
    }
}

