//
//  RandomGifRequestPerformable.swift
//  Giphity
//
//  Created by Galushka on 4/18/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol RandomGIFRequestPerformable {
    func randomGif() -> Promise<GiphyResponse<GifObject>>
}
