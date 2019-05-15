//
//  TrandingGIFsRequestPerformable.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol TrandingGIFsRequestPerformable {
    func trandingGIFs(limit: Int, offset: Int) -> Promise<GiphySearchResponse>
    
    func trandingGIFs(offset: Int) -> Promise<GiphySearchResponse>
    
    func trandingGIFs() -> Promise<GiphySearchResponse>
}
