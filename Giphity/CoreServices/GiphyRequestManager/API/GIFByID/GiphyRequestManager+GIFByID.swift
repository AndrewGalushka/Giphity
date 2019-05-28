//
//  GiphyRequestManager+GIFByID.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

extension GiphyRequestManager: GIFByIDRequestPerformable {
    
    func gifByID(_ gifID: String) -> Promise<GiphyResponse<GifObject>> {
        let queryItems = [URLQueryItem(name: "gif_id", value: gifID)]
        let requestCommand = HTTPRequestCommand(method: .get, path: "/gifs/", queryItems: queryItems)
        
        return self.execute(requestCommand)
    }
}
