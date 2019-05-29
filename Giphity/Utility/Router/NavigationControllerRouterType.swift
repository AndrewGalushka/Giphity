//
//  RouterType.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol NavigationControllerRouterSettingsType {
    typealias WillPopAction = () -> Void
    typealias DidPopAction = () -> Void
    
    var animated: Bool { get }
    var willPopAction: WillPopAction? { get }
    var didPopAction: DidPopAction? { get }
}

protocol NavigationControllerRouterType {
    func push(module: ViewControllerModule, settings: NavigationControllerRouterSettingsType?)
}
