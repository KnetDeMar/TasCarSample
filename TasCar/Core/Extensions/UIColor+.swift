//
//  UIColor+.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: - Properties
    
    /// Return a inverted color
    var inverted: UIColor {
        var red: CGFloat = CGFloat.zero, green: CGFloat = CGFloat.zero, blue: CGFloat = CGFloat.zero, alpha: CGFloat = CGFloat.zero
        UIColor.red.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: (1.0 - red), green: (1.0 - green), blue: (1.0 - blue), alpha: alpha) // Assuming you want the same alpha value.
    }
    
    /// Get a UIColor from rgb value and alpha
    ///
    /// - Parameters:
    ///     - rgbValue : the int value of color to get the UIColor
    ///     - alpha : alpha opacity of the color default value is 1.0 = 100%
    /// - Returns: UIColor with the rgb value
    class func rgb(rgbValue: UInt32, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    /// Get a UIColor from two colors for degradate
    ///
    /// - Parameters:
    ///     - bounds : Size of patter image
    ///     - fromColor : Initial color
    ///     - toColor : Final color
    ///     - orientation : Orientation degradate
    /// - Returns: UIColor pattern
    static func degradateColor(bounds: CGRect, fromColor: UIColor, toColor: UIColor, orientation: DegradateOrientation ) -> UIColor {
        return UIColor(patternImage: UIImage.degradate(bounds: bounds, fromColor: fromColor, toColor: toColor, orientation: orientation))
    }
    
}
