//
//  MainFlowCoordinator.swift
//  Giphity
//
//  Created by Galushka on 4/8/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

class MainFlowCoordinator: FlowCoordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let randomGifViewController = RandomGifViewController.loadFromStoryboard()
        randomGifViewController.tabBarItem = UITabBarItem(title: "Random", image: nil, selectedImage: nil)
        let searchGifsViewController = SearchGifsViewController.loadFromStoryboard()
        searchGifsViewController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        
        let tabbarController = UITabBarController()
        tabbarController.setViewControllers([searchGifsViewController, randomGifViewController], animated: false)
        tabbarController.selectedIndex = 1
        
        window.rootViewController = tabbarController
    }
}
