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
        nextRandomGifButton.setTitle("Next Random GIF", for: .normal)
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
        
        let animator = self.alphaAnimator(for: self.imageView)
        
        PromiseKit.firstly { () -> Promise<UIImage> in
            self.nextRandomGifButton.isEnabled = false
            return self.randomGifService.randomGif()
        }.done(on: DispatchQueue.main) {
            animator.startAnimation()
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
    
    func alphaAnimator(for view: UIView, duration animationTotalDuration: TimeInterval = 0.25) -> UIViewPropertyAnimator {
        let alphaDecreaseStartTime = 0.0
        let alphaDecreaseDuration = animationTotalDuration * 0.2
        let alphaIncreaseStartTime = alphaDecreaseDuration
        let alphaIncreaseDuration = animationTotalDuration - alphaDecreaseDuration
        
        let alphaDecreaseValue: CGFloat = 0.6
        let alphaIncreaseValue: CGFloat = 1.0
        
        let animator = UIViewPropertyAnimator(duration: 0.25, curve: UIView.AnimationCurve.easeOut) {
            UIView.animateKeyframes(withDuration: 0.25, delay: 0.0,animations: {
                UIView.addKeyframe(withRelativeStartTime: alphaDecreaseStartTime, relativeDuration: alphaDecreaseDuration, animations: {
                    view.alpha = alphaDecreaseValue
                })
                
                UIView.addKeyframe(withRelativeStartTime: alphaIncreaseStartTime, relativeDuration: alphaIncreaseDuration, animations: {
                    view.alpha = alphaIncreaseValue
                })
            })
        }
        
        return animator
    }
}

