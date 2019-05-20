//
//  GiphySearchResponseMapperType.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol GiphySearchResponseConvertorType {
    typealias AssociatedImageResult = (gifObject: GifObject, image: ImageObject)
    
    func convertToGIFsObjects(_ response: GiphySearchResponse) -> [GifObject]
    func convertToImageObjects(_ gifObjects: [GifObject], ofType: ImageObject.ImageType) -> [ImageObject]
    func convertToImageObjects(_ response: GiphySearchResponse, ofType: ImageObject.ImageType) -> [ImageObject]
    func convertToAssociatedImages(_ response: GiphySearchResponse, ofType: ImageObject.ImageType) -> [AssociatedImageResult]
    func convertToAssociatedImages(_ gifObjects: [GifObject], ofType imageType: ImageObject.ImageType) -> [AssociatedImageResult]
}
