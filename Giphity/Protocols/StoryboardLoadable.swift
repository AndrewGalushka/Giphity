//
//  StoryboardLoadable.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

protocol StoryboardLoadable: InterfaceBuilderIdentifiable {
    static var associatedStoryboard: String { get }
    static func loadFromStoryboard() -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    static func loadFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: associatedStoryboard, bundle: Bundle(for: self))
        return storyboard.instantiate(self)
    }
}
