//
//  InterfaceBuilderIdentifiable.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

protocol InterfaceBuilderIdentifiable {
    static var interfaceBuilderIdentifier: String { get }
}

extension InterfaceBuilderIdentifiable {
    static var interfaceBuilderIdentifier: String {
        return "\(self)"
    }
}

extension UIViewController: InterfaceBuilderIdentifiable {}
