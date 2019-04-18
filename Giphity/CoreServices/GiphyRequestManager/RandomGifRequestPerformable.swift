//
//  RandomGifRequestPerformable.swift
//  Giphity
//
//  Created by Galushka on 4/18/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol RandomGifRequestPerformable {
    func randomGif() -> Promise<GiphyResponse<GifObject>>
    func randomGif(completion: @escaping (_ result: Swift.Result<GiphyResponse<GifObject>, GiphyRequestManagerError>) -> Void)
}
