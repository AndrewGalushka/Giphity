//
//  GIFDetailViewController.swift
//  Giphity
//
//  Created by Galushka on 5/27/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit
import AVFoundation

class GIFDetailViewController: UIViewController, GIFDetailView {

    // MARK: - Properties(IBOutlet)
    
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var loadingGIFIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    
    // MARK: - Properties(Public)
    
    weak var presenter: GIFDetailViewPresenter?
    
    // MARK: - Properties(Private)
    
    private let gradient: CAGradientLayer =  CAGradientLayer()
    private lazy var stateMachine = StateMachine(vc: self)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGradient()
        self.presenter?.viewLoaded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = self.view.bounds
    }
    
    // MARK: GIFDetailView Imp
    
    func displayGIF(_ image: UIImage) {
        self.stateMachine.setState(.displayingGIF)
        self.gifImageView.image = image
    }
    
    func showLoadingGIFIndicator() {
        self.stateMachine.setState(.loading)
    }
    
    func hideLoadingGIFIndicator() {
        self.loadingGIFIndicator.stopAnimating()
    }
    
    func displayError(_ error: Error) {
        self.stateMachine.setState(.retryButtonActive)
    }
    
    func shareGIF(data: Data) {
        let activityVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // MARK: - Methods(IBAction)
    
    @IBAction func retryButtonTouchUpInsideActionHandler(_ sender: Any) {
        self.presenter?.retry()
    }
    
    @IBAction func shareButtonTouchUpInside(_ sender: Any) {
        self.presenter?.shareGIF()
    }
    
    // MARK: Methods(Private)
    
    private func configureGradient() {
        gradient.colors = [UIColor.blue.cgColor, UIColor.gray.cgColor, UIColor.green.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
        gradient.frame = self.view.bounds
    }
}

extension GIFDetailViewController {
    enum State {
        case initial
        case loading
        case displayingGIF
        case retryButtonActive
    }
    
    fileprivate struct StateMachine {
        private(set) var state: State = .initial
        private weak var vc: GIFDetailViewController?
        
        init(vc: GIFDetailViewController) {
            self.vc = vc
        }
        
        mutating func setState(_ state: State) {
            self.state = state
            
            switch state {
            case .initial:
                vc?.loadingGIFIndicator.stopAnimating()
                vc?.gifImageView.image = nil
                vc?.retryButton.isHidden = true
            case .loading:
                vc?.gifImageView.image = nil
                vc?.retryButton.isHidden = true
                vc?.loadingGIFIndicator.startAnimating()
            case .displayingGIF:
                vc?.retryButton.isHidden = true
                vc?.loadingGIFIndicator.stopAnimating()
            case .retryButtonActive:
                vc?.loadingGIFIndicator.stopAnimating()
                vc?.gifImageView.image = nil
                vc?.retryButton.isHidden = false
            }
        }
    }
}
