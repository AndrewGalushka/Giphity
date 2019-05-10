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
    
    func assemblyRandomGifModule() -> RandomGifModule {
        let randomGifService = self.assemblyRandomGifService()
        
        let viewController = RandomGifViewController.loadFromStoryboard()
        let presentor = RandomGifPresenter(randomGifService: randomGifService)
        
        return RandomGifModule(view: viewController, presentor: presentor)
    }
    
    func assemblySearchGIFsModule() -> ViewControllerModule {
        let paginationSearchGIFsService = self.assemblySearchGIFsPaginationService()
        
        let viewController = SearchGifsViewController.loadFromStoryboard()
        let presenter = SearchGifsPresenter(searchService: paginationSearchGIFsService)
        
        return SearchGIFsModule(view: viewController, presenter: presenter)
    }
    
    private func assemblyRandomGifService() -> RandomGifServiceType {
        return RandomGifService(gifFetcher: assembler.assemblyGifFetcher(),
                                requestManager: assembler.assemblyGiphyRequestManager())
    }
    
    private func assemblySearchGIFsService() -> SearchGIFsServiceType {
        return SearchGIFsService(requestManager: assembler.assemblyGiphyRequestManager())
    }
    
    private func assemblySearchGIFsPaginationService() -> SearchGIFsPaginationServiceType {
        let searchService: SearchGIFsServiceType = self.assemblySearchGIFsService()
        return SearchGIFsPaginationService(searchGIFsService: searchService)
    }
}
