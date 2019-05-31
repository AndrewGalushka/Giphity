//
//  SingleGIFObjectServiceType.swift
//  Giphity
//
//  Created by Galushka on 5/30/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import PromiseKit

protocol SingleGIFObjectServiceType {
    func gifImage(for size: ImageObject.ImageType) -> Promise<UIImage>
    func reload()
    func gifRawData() -> Promise<Data>
}
