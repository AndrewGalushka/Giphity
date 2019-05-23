//
//  TrendingGIFsPaginationServiceType.swift
//  Giphity
//
//  Created by Galushka on 5/23/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol TrendingGIFsPaginationServiceType: AnyObject {
    var isFetchingInProcess: Bool { get }
    var delegate: TrendingGIFsPaginationServiceDelegate? { get set }
    func firstBatch()
    func nextBatch()
}

protocol TrendingGIFsPaginationServiceDelegate: AnyObject {
    func searchGIFsPaginationService(_ service: TrendingGIFsPaginationServiceType, didFetchFirstBatch: [GifObject])
    func searchGIFsPaginationService(_ service: TrendingGIFsPaginationServiceType, didFetchNextBatch: [GifObject])
    func searchGIFsPaginationService(_ service: TrendingGIFsPaginationServiceType, didFailToFetchFirstBatch error: Error)
    func searchGIFsPaginationService(_ service: TrendingGIFsPaginationServiceType, didFailToFetchNextBatch error: Error)
}
