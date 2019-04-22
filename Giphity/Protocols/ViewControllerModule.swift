//
//  ViewControllerModule.swift
//  Giphity
//
//  Created by Galushka on 4/22/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

protocol ViewControllerModule: AnyObject {
    var asViewController: UIViewController { get }
}
