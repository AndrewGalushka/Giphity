//
//  GiphyRequestManager+RandomGIF.swift
//  Giphity
//
//  Created by Galushka on 5/6/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

extension GiphyRequestManager: RandomGIFRequestPerformable {
    
    func randomGif() -> Promise<GiphyResponse<GifObject>> {
        let requestCommand = HTTPRequestCommand(method: .get, path: "/gifs/random", queryItems: nil)
        
        return self.execute(requestCommand)
    }
}
