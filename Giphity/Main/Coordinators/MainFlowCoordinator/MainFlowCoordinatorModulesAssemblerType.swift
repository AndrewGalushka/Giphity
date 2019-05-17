//
//  MainFlowCoordinatorModulesAssemblerType.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol MainFlowCoordinatorModulesAssemblerType {
    func assembleRandomGifModule() -> RandomGifModule
    func assembleSearchGIFsModule() -> ViewControllerModule
    func assembleTrendingGIFsModule() -> TrendingGIFsModule
}
