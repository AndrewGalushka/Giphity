//
//  UIStoryboard+ViewControllerInstantiation.swift
//  Giphity
//
//  Created by Galushka on 4/4/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiate<V: UIViewController>(_ v: V.Type) -> V {
        return self.instantiateViewController(withIdentifier: v.interfaceBuilderIdentifier) as! V
    }
}
