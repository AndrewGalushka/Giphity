//
//  AppDelegate.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flowCoordinator: FlowCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let flowCoordinator: FlowCoordinator = MainFlowCoordinator(window: window)
        
        self.window = window
        self.flowCoordinator = flowCoordinator
        
        self.flowCoordinator.start()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

