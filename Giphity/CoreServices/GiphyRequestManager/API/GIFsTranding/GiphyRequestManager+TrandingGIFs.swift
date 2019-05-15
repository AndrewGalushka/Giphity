//
//  GiphyRequestManager+TrandingGIFs.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

extension GiphyRequestManager: TrandingGIFsRequestPerformable {
    
    func trandingGIFs(limit: Int, offset: Int) -> Promise<GiphySearchResponse> {
        return self._trandingGIFs(limit: limit, offset: offset)
    }
    
    func trandingGIFs(offset: Int) -> Promise<GiphySearchResponse> {
        return self._trandingGIFs(offset: offset)
    }
    
    func trandingGIFs() -> Promise<GiphySearchResponse> {
        return self._trandingGIFs()
    }
    
    private func _trandingGIFs(limit: Int = 15, offset: Int = 0) -> Promise<GiphySearchResponse> {
        let queryItems = [URLQueryItem(name: "limit", value: "\(limit)"),
                          URLQueryItem(name: "offset", value: "\(offset)")]
        
        let requestCommand = HTTPRequestCommand(method: .get, path: "/gifs/trending", queryItems: queryItems)
        return self.execute(requestCommand)
    }
}
