//
//  GiphyRequestManagerType.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

enum GiphyRequestManagerError: RawRepresentable, Error {
    
    case forbidden // 403
    case notFound // 404
    case tooManyRequests // 429
    case other(Int)
    
    init?(rawValue: Int) {
        switch rawValue {
        case 200..<300:
            return nil
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 429:
            self = .tooManyRequests
        default:
            self = .other(rawValue)
        }
    }
    
    var rawValue: Int {
        switch self {
        case .forbidden:
            return 403
        case .notFound:
            return 404
        case .tooManyRequests:
            return 429
        case .other(let code):
            return code
        }
    }
}

class GiphyRequestManager {
    private let apiKey = "cS2x8egoJJkpGz9takXkr2O2Cf1OSPJr"
    
    func randomGif(completion: @escaping (_ result: Result<Data, GiphyRequestManagerError>) -> Void) {
        var urlComponents = URLComponents(string: "https://api.giphy.com/v1/gifs/random")!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "get"
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            
            if let validationError = self?.validateForError(response: response, error: error) {
                completion(.failure(validationError))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.other(0)))
            }
        }.resume()
    }
    
    private func validateForError(response: URLResponse?, error: Error?) -> GiphyRequestManagerError? {
        
        if let error = (error as NSError?) {
            return .other(error.code)
        } else if let httpResponse = (response as? HTTPURLResponse), let responseError = GiphyRequestManagerError(rawValue: httpResponse.statusCode) {
            return responseError
        }
        
        return nil
    }
}
