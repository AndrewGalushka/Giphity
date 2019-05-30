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
        let requestCommand = HTTPRequestCommand(method: .get, path: "/gifs/\(gifID)", queryItems: nil)
        
        return self.execute(requestCommand)
    }
}
