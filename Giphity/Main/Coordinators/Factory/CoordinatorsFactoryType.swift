//
//  CoordinatorsFactoryType.swift
//  Giphity
//
//  Created by Galushka on 4/19/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import class UIKit.UIWindow
import AVFoundation

protocol CoordinatorsFactoryType {
    func makeMainFlowCoordinator(window: UIWindow, assemler: ApplicationAssemblerType) -> MainFlowCoordinator
}
