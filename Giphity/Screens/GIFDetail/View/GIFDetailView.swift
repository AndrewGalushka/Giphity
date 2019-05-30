//
//  GIFDetailView.swift
//  Giphity
//
//  Created by Galushka on 5/27/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

protocol GIFDetailView: AnyObject {
    func showLoadingGIFIndicator()
    func hideLoadingGIFIndicator()
    func displayGIF(_ image: UIImage)
    func displayError(_ error: Error)
}
