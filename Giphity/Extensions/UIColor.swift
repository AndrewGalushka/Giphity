//
//  UIColor.swift
//  Giphity
//
//  Created by Galushka on 4/10/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgba(_ red: UInt, _ green: UInt, _ blue: UInt, _ alpha: CGFloat = 1.0) -> UIColor {
        let fRed = CGFloat(red) / 255.0
        let fBlue = CGFloat(green) / 255.0
        let fBreen = CGFloat(blue) / 255.0
        
        return UIColor(red: fRed, green: fBlue, blue: fBreen, alpha: alpha)
    }
}
