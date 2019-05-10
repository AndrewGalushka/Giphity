//
//  SearchGifsViewPresenter.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol SearchGifsViewPresenter: AnyObject {
    func viewLoaded()
    func searchGIFs(by name: String)
    func nextBatchOfGIFs()
}
