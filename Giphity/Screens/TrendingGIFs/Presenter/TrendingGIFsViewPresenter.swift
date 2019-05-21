//
//  TrendingGIFsViewPresenter.swift
//  Giphity
//
//  Created by Galushka on 5/15/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol TrendingGIFsViewPresenter: AnyObject {
    func viewWillAppear()
    func trendingGIFs()
    func nextBatchOfGIFs()
}
