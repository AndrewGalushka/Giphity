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
    func asynchronouslyConvertDataToGifImage(data: Data) -> Guarantee<UIImage?> {
        return self.asynchronouslyConvertDataToGifImage(data: data, queue: DispatchQueue.global())
    }
    
    func asynchronouslyConvertDataToGifImage(data: Data, queue: DispatchQueue) -> Guarantee<UIImage?> {
        
        return Guarantee<UIImage?>.init(resolver: { (completion) in
            queue.async { [weak self] in
                guard let `self` = self else { return }
                
                let image = self.gifImage(from: data)
                completion(image)
            }
        })
    }
    
    func gifImage(from data: Data) -> UIImage? {
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let imagesCount = CGImageSourceGetCount(imageSource)
        
        guard imagesCount > 0 else { return nil }
        
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
            
            images.append(UIImage(cgImage: cgImage))
            duration += delay
        }
        
        guard images.count > 0 else { return nil }
        
        return UIImage.animatedImage(with: images, duration: duration)
    }
}
