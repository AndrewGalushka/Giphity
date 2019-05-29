//
//  ServicesAssemblerType.swift
//  Giphity
//
//  Created by Galushka on 5/29/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol ServicesAssemblerType {
    func assembleRandomGifService() -> RandomGifServiceType
    func assembleSearchGIFsService() -> SearchGIFsServiceType
    func assembleSearchGIFsPaginationService() -> SearchGIFsPaginationServiceType
    func assembleTrendingGIFsService() -> TrendingGIFsServiceType
    func assembleTrendingGIFsPaginationService() -> TrendingGIFsPaginationServiceType
}
