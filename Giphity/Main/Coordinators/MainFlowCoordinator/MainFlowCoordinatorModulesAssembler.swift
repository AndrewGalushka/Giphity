//
//  MainFlowCoordinatorModulesAssembler.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class MainFlowCoordinatorModulesAssembler: MainFlowCoordinatorModulesAssemblerType {
    private let assembler: ApplicationAssemblerType
    
    init(assembler: ApplicationAssemblerType) {
        self.assembler = assembler
    }
    
    func assembleRandomGifModule() -> RandomGifModule {
        let randomGifService = self.assembleRandomGifService()
        
        let viewController = RandomGifViewController.loadFromStoryboard()
        let presentor = RandomGifPresenter(randomGifService: randomGifService)
        
        return RandomGifModule(view: viewController, presentor: presentor)
    }
    
    func assembleSearchGIFsModule() -> ViewControllerModule {
        let paginationSearchGIFsService = self.assembleSearchGIFsPaginationService()
        
        let viewController = SearchGifsViewController.loadFromStoryboard()
        let presenter = SearchGifsPresenter(searchService: paginationSearchGIFsService)
        
        return SearchGIFsModule(view: viewController, presenter: presenter)
    }
    
    func assembleTrendingGIFsModule() -> TrendingGIFsModule {
        let view = TrendingGIFsViewController.loadFromStoryboard()
        let presenter = TrendingGIFsPresenter()
        
        return TrendingGIFsModule(view: view, presenter: presenter)
    }
    
    private func assembleRandomGifService() -> RandomGifServiceType {
        return RandomGifService(gifFetcher: assembler.assembleGifFetcher(),
                                requestManager: assembler.assembleGiphyRequestManager())
    }
    
    private func assembleSearchGIFsService() -> SearchGIFsServiceType {
        return SearchGIFsService(requestManager: assembler.assembleGiphyRequestManager())
    }
    
    private func assembleSearchGIFsPaginationService() -> SearchGIFsPaginationServiceType {
        let searchService: SearchGIFsServiceType = self.assembleSearchGIFsService()
        return SearchGIFsPaginationService(searchGIFsService: searchService)
    }
}
