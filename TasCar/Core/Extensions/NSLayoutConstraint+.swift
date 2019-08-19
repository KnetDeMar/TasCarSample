//
//  NSLayoutConstraint.swift
//  TasCar
//
//  Created by Enrique Canedo on 23/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    /// Change multiplier from existing Constraint
    ///
    /// - Parameters:
    ///     - multiplier : New multiplier value
    /// - Returns: NSLayoutConstraint
    func constraint(withMultiplier multiplier: CGFloat) -> NSLayoutConstraint {
        guard let firstItem = firstItem else { return self }
        
        return NSLayoutConstraint(item: firstItem, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
    }
    
}
