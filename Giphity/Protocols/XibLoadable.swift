//
//  XibLoadable.swift
//  Giphity
//
//  Created by Galushka on 4/5/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import UIKit

protocol XibLoadable: AnyObject, InterfaceBuilderIdentifiable {
    static var associatedXib: String { get }
    static func loadFromXib() -> Self
}

extension XibLoadable {
    static var associatedXib: String {
        return "\(self)"
    }
    
    static func loadFromXib() -> Self {
        let nib = UINib(nibName: associatedXib, bundle: Bundle(for: self))
        
        guard let view = nib.instantiate(withOwner: nil, options: nil).first(where: { $0 is Self }) else {
            fatalError("Error: Unable to load \(Self.associatedXib) from XIB")
        }
        
        return view as! Self
    }
}
