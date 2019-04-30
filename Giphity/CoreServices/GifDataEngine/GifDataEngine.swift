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
    
    func createGIFImage(using data: Data) -> UIImage? {
        let options = self.downsampleOptions(forSize: nil)
        return self.gifImage(from: data, downsampleOptions: options)
    }
    
    func createGIFImage(using data: Data, preferredSize: CGSize) -> UIImage? {
        let options = self.downsampleOptions(forSize: preferredSize)
        return self.gifImage(from: data, downsampleOptions: options)
    }
    
    private func gifImage(from data: Data, downsampleOptions: CFDictionary) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false]
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions as CFDictionary) else {
            return nil
        }
        
        let imagesCount = CGImageSourceGetCount(imageSource)
        
        guard imagesCount > 0 else { return nil }
        
        
        var images = [UIImage]()
        var duration: Double = 0.0
        
        for i in 0..<imagesCount {
            guard let cgImage = CGImageSourceCreateThumbnailAtIndex(imageSource, i, downsampleOptions) else {
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
    
    private func downsampleOptions(forSize size: CGSize?) -> CFDictionary {
        var downsampleOptions: [AnyHashable: Any] = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                                     kCGImageSourceShouldCacheImmediately: true,
                                                     kCGImageSourceCreateThumbnailWithTransform: true]
        
        if let size = size {
            let maxPixelSize = max(size.width, size.height) * UIScreen.main.scale
            downsampleOptions[kCGImageSourceThumbnailMaxPixelSize] = maxPixelSize
        }
        
        return downsampleOptions as CFDictionary
    }
}
