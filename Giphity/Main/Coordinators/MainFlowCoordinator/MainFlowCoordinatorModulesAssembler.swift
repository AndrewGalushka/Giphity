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
    
    func asseblyRandomGifModule() -> RandomGifModule {
        let randomGifService = self.assemblyRandomGifService()
        
        let viewController = RandomGifViewController.loadFromStoryboard()
        let presentor = RandomGifPresentor(randomGifService: randomGifService)
        
        return RandomGifModule(view: viewController, presentor: presentor)
    }
    
    private func assemblyRandomGifService() -> RandomGifServiceType {
        return RandomGifService(gifFetcher: assembler.assemblyGifFetcher(),
                                requestManager: assembler.assemblyGiphyRequestManager())
    }
}
