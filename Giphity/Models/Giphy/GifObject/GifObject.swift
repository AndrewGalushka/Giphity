//
//  GifObject.swift
//  Giphity
//
//  Created by Galushka on 4/8/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

struct GifObject {
    
    /// By default, this is almost always gif
    let type: String
    
    /// GIF's unique ID
    let identifier: String
    
    /// The unique slug used in this GIF's URL
    let slug: String?
    
    /// The unique URL for this GIF
    let url: String
    
    /// The unique bit.ly URL for this GIF
    let bitly_url: String?
    
    /// A URL used for embedding this GIF
    let embed_url: String?
    
    /// The username this GIF is attached to, if applicable
    var username: String?
    
    /// The page on which this GIF was found
    let source: String?
    
    /// The MPAA-style rating for this content. Examples include Y, G, PG, PG-13 and R
    let rating: String?
    
    /// The top level domain of the source URL.
    let source_tld: String?
    
    /// The URL of the webpage on which this GIF was found.
    let source_post_url: String?
    
    /// The date on which this GIF was last updated.
    let update_datetime: String?
    
    /// The date this GIF was added to the GIPHY database.
    let create_datetime: String?
    
    /// The creation or upload date from this GIF's source.
    let import_datetime: String?
    
    /// The date on which this gif was marked trending, if applicable.
    let trending_datetime: String?
    
    /// The title that appears on giphy.com for this GIF.
    let title: String?
    
    /// An object containing data for various available formats and sizes of this GIF.
    let images: ImagesObject?
}

extension GifObject: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case identifier = "id"
        case slug
        case url
        case bitly_url
        case embed_url
        case username
        case source
        case rating
        case source_tld
        case source_post_url
        case update_datetime
        case create_datetime
        case import_datetime
        case trending_datetime
        case title
        case images
    }
}



