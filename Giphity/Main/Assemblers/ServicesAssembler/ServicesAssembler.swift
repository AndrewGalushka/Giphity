//
//  ServicesAssembler.swift
//  Giphity
//
//  Created by Galushka on 5/29/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

class ServicesAssembler: ServicesAssemblerType {
    
    // MARK: - Properties(Private)
    
    private let appAssembler: ApplicationAssemblerType
    
    // MARK: - Initializers
    
    init(appAssembler: ApplicationAssemblerType) {
        self.appAssembler = appAssembler
    }
    
    // MARK: - ServicesAssemblerType Imp
    
    func assembleRandomGifService() -> RandomGifServiceType {
        return RandomGifService(gifFetcher: appAssembler.assembleGifFetcher(),
                                requestManager: appAssembler.assembleGiphyRequestManager())
    }
    
    func assembleSearchGIFsService() -> SearchGIFsServiceType {
        return SearchGIFsService(requestManager: appAssembler.assembleGiphyRequestManager())
    }
    
    func assembleSearchGIFsPaginationService() -> SearchGIFsPaginationServiceType {
        let searchService: SearchGIFsServiceType = self.assembleSearchGIFsService()
        return SearchGIFsPaginationService(searchGIFsService: searchService)
    }
    
    func assembleTrendingGIFsService() -> TrendingGIFsServiceType {
        return TrendingGIFsService(requestManager: self.appAssembler.assembleGiphyRequestManager())
    }
    
    func assembleTrendingGIFsPaginationService() -> TrendingGIFsPaginationServiceType {
        let trendingGIFsService: TrendingGIFsServiceType = self.assembleTrendingGIFsService()
        return TrendingGIFsPaginationService(trendingGIFsService: trendingGIFsService)
    }
    
    func assembleSingleGIFObjectService(gifID: String) -> SingleGIFObjectServiceType {
        let singleGIFObjectService = SingleGIFObjectService(gifID: gifID,
                                                            gifByIDService: self.assembleGIFByIDService(),
                                                            gifFetcher: self.appAssembler.assembleGifFetcher())
        
        return singleGIFObjectService
    }
    
    private func assembleGIFByIDService() -> GIFByIDServiceType {
        let requestManager = appAssembler.assembleGiphyRequestManager()
        return GIFByIDService(requestManager: requestManager)
    }
}
