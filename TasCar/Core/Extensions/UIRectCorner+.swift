//
//  UIRectCorner+.swift
//  TasCar
//
//  Created by Enrique Republic on 30/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

extension UIRectCorner {
    
    /// Retrieve a corners format CACornerMask by UIRectCorner options
    var maskedCorners: CACornerMask {
        var maskedCorners = CACornerMask()
        if contains(.bottomLeft) {
            maskedCorners.insert(.layerMinXMaxYCorner)
        }
        if contains(.bottomRight) {
            maskedCorners.insert(.layerMaxXMaxYCorner)
        }
        if contains(.topLeft) {
            maskedCorners.insert(.layerMinXMinYCorner)
        }
        if contains(.topRight) {
            maskedCorners.insert(.layerMaxXMinYCorner)
        }
        return maskedCorners.isEmpty ? [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner] : maskedCorners
    }
    
}
