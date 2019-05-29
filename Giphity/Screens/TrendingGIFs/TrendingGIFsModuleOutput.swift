//
//  TrendingGIFsModuleOutput.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol TrendingGIFsModuleOutput: AnyObject {
    func trendingGIFsModule(_ trendingGIFsModule: TrendingGIFsModule, didSelectGIFWithID gifID: String)
}
