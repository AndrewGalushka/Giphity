//
//  GiphyRequestManagerType.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

class GiphyRequestManager {
    private let apiKey = "cS2x8egoJJkpGz9takXkr2O2Cf1OSPJr"
    
    func randomGif(completion: @escaping (_ result: Result<Data, Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://api.giphy.com/v1/gifs/random")!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "get"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            }
        }.resume()
    }
}
