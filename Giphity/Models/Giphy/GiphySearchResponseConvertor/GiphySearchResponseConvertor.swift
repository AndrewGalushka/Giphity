//
//  GiphySearchResponseConvertor.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

struct GiphySearchResponseConvertor: GiphySearchResponseConvertorType {
    
    func convertToGIFsObjects(_ response: GiphySearchResponse) -> [GifObject] {
        guard let gifObjects = response.gifObjects else { return [] }
        return gifObjects
    }
    
    func convertToImageObjects(_ gifObjects: [GifObject], ofType imageType: ImageObject.ImageType) -> [ImageObject] {
        var images = [ImageObject]()
        
        for gifObject in gifObjects {
            
            if let image = gifObject.images?.imageObject(for: imageType) {
                images.append(image)
            }
        }
        
        return images
    }
    
    func convertToImageObjects(_ response: GiphySearchResponse, ofType imageType: ImageObject.ImageType) -> [ImageObject] {
        let gifObjects = self.convertToGIFsObjects(response)
        let images = self.convertToImageObjects(gifObjects, ofType: imageType)
        
        return images
    }
}
