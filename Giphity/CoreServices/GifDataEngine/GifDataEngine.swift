//
//  GifDataEngine.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit
import PromiseKit

class GifDataEngine: GifDataEngineType {
    
    func gifImage(from data: Data) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false]
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions as CFDictionary) else {
            return nil
        }
        
        let imagesCount = CGImageSourceGetCount(imageSource)
        
        guard imagesCount > 0 else { return nil }
        
        
        var images = [UIImage]()
        var duration: Double = 0.0
        
        for i in 0..<imagesCount {
            let donwsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                     kCGImageSourceShouldCacheImmediately: true,
                                     kCGImageSourceCreateThumbnailWithTransform: true] as CFDictionary
            
            guard let cgImage = CGImageSourceCreateThumbnailAtIndex(imageSource, i, donwsampleOptions) else {
                continue
            }
            
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) else {
                continue
            }
            
            guard let gifDict = (properties as NSDictionary)["{GIF}"] as? NSDictionary else {
                continue
            }
            
            guard let delay = gifDict["DelayTime"] as? Double else {
                continue
            }
        
            images.append(UIImage(cgImage: cgImage))
            duration += delay
        }
        
       return UIImage.animatedImage(with: images, duration: duration)
    }
}
