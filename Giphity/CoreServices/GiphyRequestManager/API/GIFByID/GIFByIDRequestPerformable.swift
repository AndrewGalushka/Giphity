//
//  GIFByIDRequestPerformable.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol GIFByIDRequestPerformable {
    func gifByID(_ gifID: String) -> Promise<GiphyResponse<GifObject>>
}
