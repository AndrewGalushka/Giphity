//
//  GiphySearchResponseMapperType.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol GiphySearchResponseConvertorType {
    func convertToGIFsObjects(_ response: GiphySearchResponse) -> [GifObject]
    func convertToImageObjects(_ gifObjects: [GifObject], ofType: ImageObject.ImageType) -> [ImageObject]
    func convertToImageObjects(_ response: GiphySearchResponse, ofType: ImageObject.ImageType) -> [ImageObject]
}
