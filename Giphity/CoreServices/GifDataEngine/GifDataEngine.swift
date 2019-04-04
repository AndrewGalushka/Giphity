//
//  GifDataEngine.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class GifDataEngine {
    
    func gifImage(from data: Data) -> UIImage? {
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let imagesCount = CGImageSourceGetCount(imageSource)
        var images = [UIImage]()
        var duration: Double = 0.0
        
        for i in 0..<imagesCount {
            
            guard
                let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil),
                let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil),
                let gifDict = (properties as NSDictionary)["{GIF}"] as? NSDictionary,
                let delay = gifDict["DelayTime"] as? Double
            else {
                continue
            }
        
            images.append( UIImage(cgImage: cgImage) )
            duration += delay
        }
        
       return UIImage.animatedImage(with: images, duration: duration)
    }
}
