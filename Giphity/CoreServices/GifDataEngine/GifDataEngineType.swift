//
//  GifDataEngineType.swift
//  Giphity
//
//  Created by Galushka on 4/18/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import PromiseKit

protocol GifDataEngineType {
    func asynchronouslyConvertDataToGifImage(data: Data, queue: DispatchQueue) -> Guarantee<UIImage?>
    func asynchronouslyConvertDataToGifImage(data: Data) -> Guarantee<UIImage?>
    func gifImage(from data: Data) -> UIImage?
}
