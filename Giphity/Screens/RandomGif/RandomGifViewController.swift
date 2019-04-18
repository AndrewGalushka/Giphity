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
    
    let giphyRequestManager = GiphyRequestManager()
    let gifFetcher = GifFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchAndDisplayNextRandomGif()
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
        imageView.image = nil
        
        let buttonActivityIndicatorCancelationToken = setLoadingState(for: self.imageView)
        let imageActivityIndicatorCancelationToken = setLoadingState(for: self.nextRandomGifButton)
        
        let resultCompletion: ((UIImage?) -> Void) = { [weak self] image in
            
            DispatchQueue.main.async {
                buttonActivityIndicatorCancelationToken()
                imageActivityIndicatorCancelationToken()
                self?.imageView.image = image
            }
        }
        
        self.giphyRequestManager.randomGif { [weak self] (response) in
            guard let strongSelf = self else { return }
            
            switch response {
            case .success(let result):
                
                if let gifObject = result.data {
                    strongSelf.gifFetcher.fetch(gifObject, competion: { (response) in
                        
                        switch response {
                        case .success(let image):
                            resultCompletion(image)
                        case .failure(_):
                            resultCompletion(nil)
                        }
                    })
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                resultCompletion(nil)
            }
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

