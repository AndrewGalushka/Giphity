//
//  ViewController.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class RandomGifViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextRandomGifButton: UIButton!
    
    let giphyRequestManager = GiphyRequestManager()
    
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
        
        self.giphyRequestManager.randomGif { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let data):
                
                strongSelf.fetchGifDataFromRandomImageResponse(data: data, competion: { (image) in
                    resultCompletion(image)
                })
                
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
    
    func fetchGifDataFromRandomImageResponse(data: Data, competion: @escaping (UIImage?) -> Void) {
        guard
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let dataDict = json["data"] as? [String: Any],
            let images = dataDict["images"] as? [String: Any],
            let fixedHeightImage = images["fixed_height"] as? [String: String],
            let urlString = fixedHeightImage["url"],
            let url = URL(string: urlString)
        else {
            competion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                let gifDataEngine = GifDataEngine()
                competion(gifDataEngine.gifImage(from: data))
            } else {
                competion(nil)
            }
            
        }.resume()
    }
}

