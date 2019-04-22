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
        let mainFlowCoordinator = MainFlowCoordinator(window: window, assembler: assemler)
        return mainFlowCoordinator
    }
}
