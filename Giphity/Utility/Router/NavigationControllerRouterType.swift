//
//  RouterType.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol NavigationControllerRouterSettingsType {
    typealias OnPopAction = () -> Void
    
    var onPopAction: OnPopAction? { get }
}

protocol NavigationControllerRouterType {
    func push(module: ViewControllerModule, animated: Bool, settings: NavigationControllerRouterSettingsType?, completion: (() -> Void)?)
}
