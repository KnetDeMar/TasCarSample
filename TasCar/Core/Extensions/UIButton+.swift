//
//  UIButton+.swift
//  TasCar
//
//  Created by Enrique Canedo on 15/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

enum ButtonCustomType { 
    
    case info, reload
    
    var image: UIImage {
        switch self {
        case .info:
            return ThemeImage.info.image
        case .reload:
            return ThemeImage.start.image
        }
    }
    
    var edges: UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
}

extension UIButton {
    
    /// Setup button to selection
    func setupSelection(withColor color: UIColor = ThemeColor.white.color) {
        backgroundColor = color
        titleLabel?.font = ThemeFont.bold16.font
        setTitleColor(ThemeColor.white.color, for: .normal)
        setTitleShadowColor(ThemeColor.black.color, for: .normal)
        titleLabel?.shadowOffset = Constants.shadowSize
        corner()
    }
    
    /// Setup button by type selected
    ///
    /// - Parameters:
    ///     - type : Type to apply
    func setupByType(_ type: ButtonCustomType, withColor color: UIColor? = ThemeColor.main.color) {
        imageEdgeInsets = type.edges
        if type != .info {
            backgroundColor = ThemeColor.transparent.color
        }
        setTitle("", for: .normal)
        if let color = color {
            setImage(type.image.fillAlpha(fillColor: color), for: .normal)
        }
    }
    
}
