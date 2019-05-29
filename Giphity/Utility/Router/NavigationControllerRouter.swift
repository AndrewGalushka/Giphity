//
//  Router.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

struct NavigationControllerRouterSettings: NavigationControllerRouterSettingsType {
    typealias OnPopAction = () -> Void
    
    var onPopAction: OnPopAction?
}

class NavigationControllerRouter: NSObject, NavigationControllerRouterType {
    
    // MARK: - Properties(Public)
    
    let navigationController: UINavigationController
    
    // MARK: - Properties(Private)
    
    private var onPopActions = [UIViewController: NavigationControllerRouterSettings.OnPopAction]()
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        
        navigationController.delegate = self
    }
    
    // MARK: - NavigationControllerRouterType Imp
    
    func push(module: ViewControllerModule, animated: Bool, settings: NavigationControllerRouterSettingsType?, completion: (() -> Void)?) {
        assertNavigationControllerDelegate()
        
        
    }
    
    // MARK: - Methods(Private)
    
    private func assertNavigationControllerDelegate() {
        assert(navigationController.delegate === self, "Delegate of navigation controller must be Self")
    }
    
    private func registerSettings(_ settings: NavigationControllerRouterSettingsType, for module: ViewControllerModule) {
        
        if let onPopAction = settings.onPopAction {
            self.onPopActions[module.asViewController] = onPopAction
        }
    }
}

extension NavigationControllerRouter: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) else {
            return
        }
        
        if let onPopAction = onPopActions[poppedViewController] {
            onPopAction()
            onPopActions.removeValue(forKey: poppedViewController)
        }
    }
}
