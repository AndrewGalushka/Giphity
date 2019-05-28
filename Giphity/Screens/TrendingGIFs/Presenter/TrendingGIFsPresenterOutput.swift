//
//  TrendingGIFsPresenterOutput.swift
//  Giphity
//
//  Created by Galushka on 5/28/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol TrendingGIFsPresenterOutput: AnyObject {
    func trendingGIFsPresenter(_ presenter: TrendingGIFsPresenter, gifSelectedWithID gifID: String)
}
