//
//  ChildCoordinatorsHoldable.swift
//  Giphity
//
//  Created by Galushka on 4/19/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol ChildCoordinatorsHoldable: AnyObject {
    var childCoordinators: [FlowCoordinatorType] { get set }
    func addChildCoordinator(_ coordinator: FlowCoordinatorType)
    func removeChildCoordinator(_ coordinator: FlowCoordinatorType)
}

extension ChildCoordinatorsHoldable {
    func addChildCoordinator(_ coordinator: FlowCoordinatorType) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: FlowCoordinatorType) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
