//
//  SearchGIFsPaginationServiceType.swift
//  Giphity
//
//  Created by Galushka on 5/8/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol SearchGIFsPaginationServiceType {
    var delegate: SearchGIFsPaginationServiceDelegate? { get set }
    func searchGIFs(by name: String)
    func nextBatch()
}

protocol SearchGIFsPaginationServiceDelegate: AnyObject {
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFetchFirstBatch: [GifObject])
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFetchNextBatch: [GifObject])
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFailToFetchFirstBatch error: Error)
    func searchGIFsPaginationService(_ service: SearchGIFsPaginationServiceType, didFailToFetchNextBatch error: Error)
}
