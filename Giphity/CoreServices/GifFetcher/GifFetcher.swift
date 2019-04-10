//
//  GifFetcher.swift
//  Giphity
//
//  Created by Galushka on 4/9/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit


class GifFetcher {
    
    let gifEngine: GifDataEngine = GifDataEngine()
    
    func fetch(_ gifObject: GifObject, competion: @escaping (_: Result<UIImage, Error>) -> Void) {
        let stabError = NSError(domain: "", code: 0, userInfo: nil)
        
        guard
            let urlString = gifObject.images?.imageObject(for: .downsized)?.url,
            let url = URL(string: urlString)
        else {
            competion(.failure(stabError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            if let data = data, let gif = self?.gifEngine.gifImage(from: data) {
                competion(.success(gif))
            } else if let error = error {
                competion(.failure(error))
            } else {
                competion(.failure(stabError))
            }
        }
        
        task.resume()
    }
}

extension GifFetcher {
    
}
