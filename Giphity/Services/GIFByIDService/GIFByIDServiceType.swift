//
//  GIFByIDServiceType.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import PromiseKit

protocol GIFByIDServiceType {
    func fetchGifObjectByID(_ gifID: String) -> Promise<GiphyResponse<GifObject>>
}
