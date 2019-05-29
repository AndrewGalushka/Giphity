//
//  Router.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

struct NavigationControllerRouterSettings: NavigationControllerRouterSettingsType {
    var animated: Bool
    var willPopAction: WillPopAction?
    var didPopAction: DidPopAction?
    
    init(animated: Bool = true, willPopAction: WillPopAction? = nil, didPopAction: DidPopAction? = nil) {
        self.animated = animated
        self.willPopAction = willPopAction
        self.didPopAction = didPopAction
    }
}

class NavigationControllerRouter: NSObject, NavigationControllerRouterType {
    
    // MARK: - Properties(Public)
    
    let navigationController: UINavigationController
    
    // MARK: - Properties(Private)
    
    private var pushedModulesSettings = [UIViewController: NavigationControllerRouterSettingsType]()
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        
        navigationController.delegate = self
    }
    
    // MARK: - NavigationControllerRouterType Imp
    
    func push(module: ViewControllerModule, settings: NavigationControllerRouterSettingsType? = nil) {
        assertNavigationControllerDelegate()
        
        let settings = settings ?? NavigationControllerRouterSettings()
        
        self.registerSettings(settings, for: module)
        navigationController.pushViewController(module.asViewController, animated: settings.animated)
    }
    
    // MARK: - Methods(Private)
    
    private func assertNavigationControllerDelegate() {
        assert(navigationController.delegate === self, "Delegate of navigation controller must be Self")
    }
    
    private func registerSettings(_ settings: NavigationControllerRouterSettingsType, for module: ViewControllerModule) { self.pushedModulesSettings[module.asViewController] = settings
    }
    
    private func unregisterSettings(for viewController: UIViewController) {
        self.pushedModulesSettings.removeValue(forKey: viewController)
    }
}

extension NavigationControllerRouter: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) else {
            return
        }

        if let settings = pushedModulesSettings[poppedViewController] {
            settings.willPopAction?()
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) else {
            return
        }

        if let settings = pushedModulesSettings[poppedViewController] {
            settings.didPopAction?()
            unregisterSettings(for: poppedViewController)
        }
    }
}
