//
//  MainFlowCoordinator.swift
//  Giphity
//
//  Created by Galushka on 4/8/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class MainFlowCoordinator: FlowCoordinatorType {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let tabbarController: UITabBarController
    private let assembler: ApplicationAssemblerType
    private let modulesAssembler: MainFlowCoordinatorModulesAssemblerType
    
    private var modules = [ViewControllerModule]()
    
    init(window: UIWindow, assembler: ApplicationAssemblerType) {
        self.window = window
        self.assembler = assembler
        self.modulesAssembler = MainFlowCoordinatorModulesAssembler(assembler: assembler)
        
        self.tabbarController = UITabBarController()
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let initialTabbarModules = makeInitialTabbarModules()
        self.addModules(initialTabbarModules)
        
        tabbarController.setViewControllers(initialTabbarModules.map { $0.asViewController }, animated: true)
        tabbarController.selectedIndex = 2
        
        navigationController.setViewControllers([tabbarController], animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window.rootViewController = navigationController
    }

    func addModule(_ module: ViewControllerModule) {
        modules.append(module)
    }
    
    func addModules(_ modules: [ViewControllerModule]) {
        self.modules.append(contentsOf: modules)
    }
    
    func removeModule(_ module: ViewControllerModule) {
        modules.removeAll { $0 === module }
    }
    
    private func makeInitialTabbarModules() -> [ViewControllerModule] {
        let trendingGIFsModule = self.modulesAssembler.assembleTrendingGIFsModule()
        let randomGIFsModule = self.modulesAssembler.assembleRandomGifModule()
        let searchGIFsModule = self.modulesAssembler.assembleSearchGIFsModule()
        
        let initialTabbarModules = [trendingGIFsModule, randomGIFsModule, searchGIFsModule]
        
        trendingGIFsModule.asViewController.tabBarItem = UITabBarItem(title: "TRENDING", image: UIImage(named: "tab_bar_icon_selected"), selectedImage: UIImage(named: "tab_bar_icon_selected"))
        randomGIFsModule.asViewController.tabBarItem = UITabBarItem(title: "RANDOM", image: UIImage(named: "tab_bar_icon_selected"), selectedImage: UIImage(named: "tab_bar_icon_selected"))
        searchGIFsModule.asViewController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(named: "tab_bar_icon_selected"), selectedImage: UIImage(named: "tab_bar_icon_selected"))
        
        return initialTabbarModules
    }
}
