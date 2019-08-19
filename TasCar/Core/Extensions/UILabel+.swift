//
//  UILabel+.swift
//  TasCar
//
//  Created by Enrique Republic on 30/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import DynamicColor

extension UILabel {
    
    /// Change background color, text and shadow with one DynamicColor
    ///
    /// - Parameters:
    ///     - withColor : apply color
    ///     - inverse: change order color for background light
    func setup(withColor color: DynamicColor = ThemeColor.transparent.color, inverse: Bool = false) {
        backgroundColor = color
        textColor = inverse ? ThemeColor.black.color : ThemeColor.white.color 
        shadowColor = inverse ? ThemeColor.white.color : ThemeColor.black.color
        shadowOffset = Constants.shadowSize
    }
    
}
