//
//  GiphyRequestManagerType.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

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

class GiphyRequestManager: RandomGifRequestPerformable {
    private let apiKey = "cS2x8egoJJkpGz9takXkr2O2Cf1OSPJr"
    private let sessionManager = Alamofire.SessionManager()
    
    func randomGif() -> Promise<GiphyResponse<GifObject>> {
        return Promise<GiphyResponse<GifObject>>.init(resolver: { (resolver) in
            self.randomGif { (response) in
                resolver.resolve(response)
            }
        })
    }
    
    func searchGifs(name query: String, limit: Int = 25, offset: Int = 0) -> Promise<GiphySearchResponse> {
        return Promise<GiphySearchResponse>.init(resolver: { (resolver) in
            self.searchGifs(name: query, limit: limit, offset: offset, completion: { (response) in
                resolver.resolve(response)
            })
        })
    }
    
    func randomGif(completion: @escaping (_ result: Swift.Result<GiphyResponse<GifObject>, GiphyRequestManagerError>) -> Void) {
        var urlComponents = URLComponents(string: "https://api.giphy.com/v1/gifs/random")!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        let urlRequest = try! URLRequest(url: urlComponents, method: .get)
        
        self.execute(urlRequest, mapDataTo: GiphyResponse<GifObject>.self, completion: completion)
    }
    
    func searchGifs(name query: String, limit: Int = 25, offset: Int = 0, completion: @escaping (_ result: Swift.Result<GiphySearchResponse, GiphyRequestManagerError>) -> Void) {
        var urlComponents = URLComponents(string: "https://api.giphy.com/v1/gifs/search")!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                    URLQueryItem(name: "q", value: query),
                                    URLQueryItem(name: "limit", value: "\(limit)"),
                                    URLQueryItem(name: "offset", value: "\(offset)")];
        
        let urlRequest = try! URLRequest(url: urlComponents, method: .get)
        
        self.execute(urlRequest, mapDataTo: GiphySearchResponse.self, completion: completion)
    }
    
    private func validateForError(response: URLResponse?, error: Error?) -> GiphyRequestManagerError? {
        
        if let error = (error as NSError?) {
            return .other(error.code)
        } else if let httpResponse = (response as? HTTPURLResponse), let responseError = GiphyRequestManagerError(rawValue: httpResponse.statusCode) {
            return responseError
        }
        
        return nil
    }
    
    private func execute<Model: Decodable>(_ urlRequest: URLRequest,
                                                              mapDataTo: Model.Type,
                                                              completion: @escaping (_ result: Swift.Result<Model, GiphyRequestManagerError>) -> Void) {
        self.execute(urlRequest) { (requestResult) in
            
            switch requestResult {
            case .success(let data):
                let mappingResult = self.map(data, to: Model.self)
                completion(mappingResult)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func execute(_ urlRequest: URLRequest,
                         completion: @escaping (_ result: Swift.Result<Data, GiphyRequestManagerError>) -> Void) {
        
        self.sessionManager.request(urlRequest).responseData { [weak self] (dataResponse) in
            guard let `self` = self else { return }
            
            if let error = self.validateForError(response: dataResponse.response, error: dataResponse.error) {
                completion(.failure(error))
                return
            }
            
            switch dataResponse.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.other(0)))
            }
        }
    }
    
    func map<Model: Decodable>(_ data: Data, to: Model.Type) -> Swift.Result<Model, GiphyRequestManagerError> {
        
        do {
            let model = try JSONDecoder().decode(Model.self, from: data)
            return .success(model)
        } catch (let error as NSError) {
            return .failure(GiphyRequestManagerError.other(error.code))
        }
    }
}
