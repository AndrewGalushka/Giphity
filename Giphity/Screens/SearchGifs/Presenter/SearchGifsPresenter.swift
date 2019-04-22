//
//  SearchGifsPresenter.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

class SearchGifsPresenter: SearchGifsViewPresenter {
    private let searchService: SearchGIFsServiceType
    
    // MARK: - Initializers
    
    init(searchService: SearchGIFsServiceType) {
        self.searchService = searchService
    }
    
    // MARK: - SearchGifsViewPresenter
    
    func searchGIFs(by name: String) {
    }
}
