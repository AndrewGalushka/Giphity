//
//  MainFlowCoordinatorModulesAssemblerType.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol MainFlowCoordinatorModulesAssemblerType {
    func assemblyRandomGifModule() -> RandomGifModule
    func assemblySearchGIFsModule() -> ViewControllerModule
    func assemblytrendingGIFsModule() -> trendingGIFsModule
}
