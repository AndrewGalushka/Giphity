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
    private let tabbarController: UITabBarController
    private let assembler: ApplicationAssemblerType
    private let modulesAssembler: MainFlowCoordinatorModulesAssemblerType
    
    private var modules = [ViewControllerModule]()
    
    init(window: UIWindow, assembler: ApplicationAssemblerType) {
        self.window = window
        self.assembler = assembler
        self.modulesAssembler = MainFlowCoordinatorModulesAssembler(assembler: assembler)
        
        self.tabbarController = UITabBarController()
    }
    
    func start() {
        let trendingGIFsModule = self.modulesAssembler.assembletrendingGIFsModule()
        let randomGIFsModule = self.modulesAssembler.assembleRandomGifModule()
        let searchGIFsModule = self.modulesAssembler.assembleSearchGIFsModule()
        
        let initialTabbarModules = [trendingGIFsModule, randomGIFsModule, searchGIFsModule]
        
        self.addModules(initialTabbarModules)
        
        trendingGIFsModule.asViewController.tabBarItem = UITabBarItem(title: "trending", image: nil, selectedImage: nil)
        randomGIFsModule.asViewController.tabBarItem = UITabBarItem(title: "Random", image: UIImage(named: "tab_bar_cube_icon"), selectedImage: nil)
        searchGIFsModule.asViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "tab_bar_search_icon"), selectedImage: nil)
        
        tabbarController.setViewControllers(initialTabbarModules.map { $0.asViewController },
                                            animated: false)
        tabbarController.selectedIndex = 1
        
        window.rootViewController = tabbarController
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
}
