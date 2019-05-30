//
//  MainFlowCoordinator.swift
//  Giphity
//
//  Created by Galushka on 4/8/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class MainFlowCoordinator: FlowCoordinatorType {
    
    // MARK: - Properties(Private)
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let tabbarController: UITabBarController
    private let navigationControllerRouter: NavigationControllerRouterType
    
    private let assembler: ApplicationAssemblerType
    private let servicesAssembler: ServicesAssemblerType
    private let modulesAssembler: MainFlowCoordinatorModulesAssemblerType
    
    private var modules = [ViewControllerModule]()
    
    // MARK: - Initializers
    
    init(window: UIWindow, assembler: ApplicationAssemblerType, servicesAssembler: ServicesAssemblerType) {
        self.window = window
        self.assembler = assembler
        self.servicesAssembler = servicesAssembler
        self.modulesAssembler = MainFlowCoordinatorModulesAssembler(servicesAssembler: servicesAssembler)
        
        self.tabbarController = UITabBarController()
        self.navigationController = UINavigationController()
        self.navigationControllerRouter = NavigationControllerRouter(navigationController: navigationController)
    }
    
    // MARK: - FlowCoordinatorType Imp
    
    func start() {
        let initialTabbarModules = makeInitialTabbarModules()
        self.addModules(initialTabbarModules)
        
        tabbarController.setViewControllers(initialTabbarModules.map { $0.asViewController }, animated: true)
        tabbarController.selectedIndex = 1
        
        navigationController.setViewControllers([tabbarController], animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window.rootViewController = navigationController
    }

    // MARK: -
    
    func addModule(_ module: ViewControllerModule) {
        modules.append(module)
    }
    
    func addModules(_ modules: [ViewControllerModule]) {
        self.modules.append(contentsOf: modules)
    }
    
    func removeModule(_ module: ViewControllerModule) {
        modules.removeAll { $0 === module }
    }
    
    // MARK: Methods(Private)
    
    private func makeInitialTabbarModules() -> [ViewControllerModule] {
        let trendingGIFsModule = self.modulesAssembler.assembleTrendingGIFsModule()
        let randomGIFsModule = self.modulesAssembler.assembleRandomGifModule()
        let searchGIFsModule = self.modulesAssembler.assembleSearchGIFsModule()
        
        let initialTabbarModules = [trendingGIFsModule, randomGIFsModule, searchGIFsModule]
        
        trendingGIFsModule.asViewController.tabBarItem = UITabBarItem(title: "TRENDING", image: UIImage(named: "tab_bar_icon_selected"), selectedImage: UIImage(named: "tab_bar_icon_selected"))
        randomGIFsModule.asViewController.tabBarItem = UITabBarItem(title: "RANDOM", image: UIImage(named: "tab_bar_icon_selected"), selectedImage: UIImage(named: "tab_bar_icon_selected"))
        searchGIFsModule.asViewController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(named: "tab_bar_icon_selected"), selectedImage: UIImage(named: "tab_bar_icon_selected"))
        
        trendingGIFsModule.moduleOutput = self
        
        return initialTabbarModules
    }
}

// MARK: - TrendingGIFsModuleOutput

extension MainFlowCoordinator: TrendingGIFsModuleOutput {
    func trendingGIFsModule(_ trendingGIFsModule: TrendingGIFsModule, didSelectGIFWithID gifID: String) {
        let gifDetailModule = self.modulesAssembler.assembleGIFDetailModule(gifIdentifier: gifID)
        
        self.addModule(gifDetailModule)
        
        let settings = NavigationControllerRouterSettings(willPopAction: {
            self.navigationController.setNavigationBarHidden(true, animated: true)
        }, didPopAction: { [weak gifDetailModule] in
            guard let gifDetailModule = gifDetailModule else { return }
            self.removeModule(gifDetailModule)
        })
        
        self.navigationControllerRouter.push(module: gifDetailModule, settings: settings)
        self.navigationController.setNavigationBarHidden(false, animated: true)
        
    }
}
