//
//  RandomGifServiceType.swift
//  Giphity
//
//  Created by Galushka on 4/18/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol RandomGifServiceType {
    func randomGif(ofSize: ImageObject.ImageType) -> Promise<UIImage>
}
