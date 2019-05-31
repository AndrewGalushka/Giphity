//
//  ImagesObject.swift
//  Giphity
//
//  Created by Galushka on 4/8/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

struct ImagesObject: Decodable {
    let images: [ImageObject]
    
    func imageObject(for imageType: ImageObject.ImageType) -> ImageObject? {
        return self.images.first(where: { $0.imageType == imageType})
    }
    
    init(from decoder: Decoder) throws {
        let imagesDicts = try decoder.singleValueContainer().decode([String: [String: String]].self)
        
        var imageObjects = [ImageObject]()
        
        for (key, value) in imagesDicts {

            guard
                let imageType = ImageObject.ImageType(rawValue: key),
                let url = value["url"],
                let width = value["width"],
                let height = value["height"]
            else {
                continue
            }
            
            let imageObject = ImageObject(url: url, width: width, height: height, mp4URL: value["mp4"], imageType: imageType)
            imageObjects.append(imageObject)
        }
        
        self.images = imageObjects
    }
}

struct ImageObject {
    let url: String
    let width: String
    let height: String
    let mp4URL: String?
    
    let imageType: ImageType
}

extension ImageObject {
    enum ImageType: String {
        /// Height set to 200px. Good for mobile use.
        case fixedHeight = "fixed_height"
        /// Static preview image for fixed_height
        case fixedHeightStill = "fixed_height_still"
        /// Height set to 200px. Reduced to 6 frames to minimize file size to the lowest. Works well for unlimited scroll on mobile and as animated previews. See GIPHY.com on mobile web as an example.
        case fixedHeight_downsampled = "fixed_height_downsampled"
        /// Width set to 200px. Good for mobile use.
        case fixedWidth = "fixed_width"
        /// Static preview image for fixed_width
        case fixedWidth_still = "fixed_width_still"
        ///  Width set to 200px. Reduced to 6 frames. Works well for unlimited scroll on mobile and as animated previews.
        case fixedWidthDownsampled = "fixed_width_downsampled"
        /// Height set to 100px. Good for mobile keyboards.
        case fixedHeight_small = "fixed_height_small"
        /// Static preview image for fixed_height_small
        case fixedHeightSmallStill = "fixed_height_small_still"
        /// Width set to 100px. Good for mobile keyboards
        case fixedWidthSmall = "fixed_width_small"
        /// Static preview image for fixed_width_small
        case fixedWidthSmallStill = "fixed_width_small_still"
        /// File size under 50kb. Duration may be truncated to meet file size requirements. Good for thumbnails and previews.
        case preview_gif = "preview_gif"
        /// File size under 200kb.
        case downsized_small
        /// File size under 2mb.
        case downsized
        /// File size under 5mb.
        case downsized_medium
        /// File size under 8mb.
        case downsized_large
        /// Static preview image for downsized
        case downsized_still
        /// Original file size and file dimensions. Good for desktop use.
        case original
        /// Preview image for original
        case original_still
        /// Duration set to loop for 15 seconds. Only recommended for this exact use case.
        case looping
    }
}
