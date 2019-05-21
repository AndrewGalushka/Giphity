//
//  RandomGifPresentorOutput.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

protocol RandomGifViewPresenter: AnyObject {
    func viewLoaded()
    func viewWillAppear()
    func nextRandomGif()
}
