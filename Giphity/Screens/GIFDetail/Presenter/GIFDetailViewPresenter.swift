//
//  GIFViewerViewPresenter.swift
//  Giphity
//
//  Created by Galushka on 5/27/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol GIFDetailViewPresenter: AnyObject {
    func viewLoaded()
    func retry()
    func shareGIF()
}
