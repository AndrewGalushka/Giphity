//
//  ApplicationCoordinator.swift
//  Giphity
//
//  Created by Galushka on 4/19/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: AppCoordinatorType, ChildCoordinatorsHoldable {
    private let window: UIWindow
    private let appAssembler: ApplicationAssemblerType
    private let coordinatorsFactory: CoordinatorsFactoryType
    var childCoordinators = [FlowCoordinatorType]()
    
    init(window: UIWindow,
         applicationAssembler: ApplicationAssemblerType = ApplicationAssembler(),
         coordinatorsFactory: CoordinatorsFactoryType = CoordinatorsFactory()) {
        self.window = window
        self.appAssembler = applicationAssembler
        self.coordinatorsFactory = coordinatorsFactory
    }
    
    func start() {
        let mainFlowCoordinator = coordinatorsFactory.makeMainFlowCoordinator(window: self.window, assemler: appAssembler)
        mainFlowCoordinator.start()
        self.addChildCoordinator(mainFlowCoordinator)
    }
}
