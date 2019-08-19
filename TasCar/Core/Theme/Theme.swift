//
//  Theme.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

// MARK: - Colors of application

enum ThemeColor {
    
    case shadow, transparent, white, black, main
    
    var color: UIColor {
        switch self {
        case .shadow:
            return UIColor.rgb(rgbValue: 0x000000, alpha: 0.15)
        case .transparent:
            return UIColor.clear
        case .white:
            return .white
        case .black:
            return .black
        case .main:
            return UIColor.rgb(rgbValue: 0x114F91)
        }
    }
    
    var cgColor: CGColor {
        return color.cgColor
    }
    
}

// MARK: - Fonts of application

enum ThemeFont {
    
    case bold29, bold22, bold16, normal20, normal17
    
    var font: UIFont {
        return UIFont(name: family, size: size) ?? UIFont()
    }
    
    // MARK: - Private attributes
    
    private var size: CGFloat {
        switch self {
        case .bold22:
            return 22.0
        case .normal20:
            return 20.0
        case .bold16:
            return 16.0
        case .normal17:
            return 17.0
        case .bold29:
            return 29.0
        }
    }
    
    private var family: String {
        switch self {
        case .bold29, .bold22, .bold16:
            return "DINAlternate-Bold"
        case .normal20, .normal17:
            return "DINCondensed-Bold"
        }
    }
    
}

// MARK: - Fonts of application

enum ThemeImage: String {
    
    case logo, info, start, close
    
    var image: UIImage {
        return UIImage(named: "ic_\(rawValue)") ?? UIImage()
    }

}
