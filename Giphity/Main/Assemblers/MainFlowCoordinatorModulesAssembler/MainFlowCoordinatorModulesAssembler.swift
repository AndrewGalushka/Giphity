//
//  MainFlowCoordinatorModulesAssembler.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class MainFlowCoordinatorModulesAssembler: MainFlowCoordinatorModulesAssemblerType {
    
    // MARK: - Properties(Private)
    
    private let assembler: ServicesAssemblerType
    
    // MARK: - Initializers
    
    init(servicesAssembler: ServicesAssemblerType) {
        self.assembler = servicesAssembler
    }
    
    // MARK: - MainFlowCoordinatorModulesAssemblerType Imp
    
    func assembleRandomGifModule() -> RandomGifModule {
        let randomGifService = self.assembler.assembleRandomGifService()
        
        let viewController = RandomGifViewController.loadFromStoryboard()
        let presenter = RandomGifPresenter(randomGifService: randomGifService)
        
        return RandomGifModule(view: viewController, presenter: presenter)
    }
    
    func assembleSearchGIFsModule() -> ViewControllerModule {
        let paginationSearchGIFsService = self.assembler.assembleSearchGIFsPaginationService()
        
        let viewController = SearchGifsViewController.loadFromStoryboard()
        let presenter = SearchGifsPresenter(searchService: paginationSearchGIFsService)
        
        return SearchGIFsModule(view: viewController, presenter: presenter)
    }
    
    func assembleTrendingGIFsModule() -> TrendingGIFsModule {
        let trendingGIFsService = self.assembler.assembleTrendingGIFsPaginationService()
        
        let view = TrendingGIFsViewController.loadFromStoryboard()
        let presenter = TrendingGIFsPresenter(trendingGIFsService: trendingGIFsService)
        
        return TrendingGIFsModule(view: view, presenter: presenter)
    }
    
    func assembleGIFDetailModule() -> GIFDetailModule {
        let view = GIFDetailViewController.loadFromStoryboard()
        let presenter = GIFDetailPresenter()
        
        return GIFDetailModule(view: view, presenter: presenter)
    }
}
