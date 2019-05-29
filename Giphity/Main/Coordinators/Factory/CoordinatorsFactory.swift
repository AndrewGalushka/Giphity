//
//  CoordinatorsFactory.swift
//  Giphity
//
//  Created by Galushka on 4/19/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class CoordinatorsFactory: CoordinatorsFactoryType {
    func makeMainFlowCoordinator(window: UIWindow, assemler: ApplicationAssemblerType) -> MainFlowCoordinator {
        let servicesAssembler = ServicesAssembler(appAssembler: assemler)
        let mainFlowCoordinator = MainFlowCoordinator(window: window, assembler: assemler, servicesAssembler: servicesAssembler)
        return mainFlowCoordinator
    }
}
