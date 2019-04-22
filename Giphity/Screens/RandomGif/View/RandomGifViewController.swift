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
    
    weak var presentor: RandomGifViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presentor?.viewLoaded()
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
        presentor?.nextRandomGif()
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

extension RandomGifViewController: RandomGifView {
    func showLoadingIndicator() {
        self.nextRandomGifButton.isEnabled = false
    }
    
    func hideLoadingIndicator() {
        self.nextRandomGifButton.isEnabled = true
    }
    
    func displayGif(_ image: UIImage) {
        self.imageView.image = image
    }
}

