//
//  UIView+.swift
//  TasCar
//
//  Created by Enrique Canedo on 10/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Create an elevate rounded view
    ///
    /// - Parameters:
    ///     - radius : Corner radius selected
    ///     - corners : Selected corner to round
    ///     - fillColor : Color of view background
    ///     - shadowColor : Color of shadow in rect
    func elevate(radius: CGFloat = Constants.radius, corners: UIRectCorner = .allCorners, fillColor: CGColor = ThemeColor.white.cgColor, shadowColor: CGColor = ThemeColor.shadow.cgColor) {
        removeLayer(withName: Constants.shadowLayerName)
        let shadowLayer = CAShapeLayer()
        shadowLayer.name = Constants.shadowLayerName
        shadowLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        shadowLayer.fillColor = fillColor
        shadowLayer.shadowColor = shadowColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: CGFloat.zero, height: Constants.shadowCornerDefault)
        shadowLayer.shadowOpacity = 1.0
        shadowLayer.shadowRadius = radius
        layer.masksToBounds = false
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    /// Make round selected corners in view
    ///
    /// - Parameters:
    ///     - radius : Corner radius selected
    ///     - corners : Corner position to round
    func corner(radius: CGFloat = Constants.radius, corners: UIRectCorner = .allCorners) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners.maskedCorners
    }
    
    /// Round view like a circle
    func rounded() {
        layer.cornerRadius = frame.height / 2.0
        layer.masksToBounds = true
    }
    
    /// Create gradient into view from white to clear
    ///
    /// - Parameters:
    ///     - withColor : Color to apply gradient
    func gradient(withColor color: UIColor = ThemeColor.white.color) {
        removeLayer(withName: Constants.gradientLayerName)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color.cgColor, color.withAlphaComponent(CGFloat.zero).cgColor]
        gradientLayer.locations = [0.0, 0.1]
        gradientLayer.frame = frame
        gradientLayer.name = Constants.gradientLayerName 
        layer.addSublayer(gradientLayer)
    }
    
    /// Remove existing layer by name
    ///
    /// - Parameters:
    ///     - withName : Name from layer that we remove
    private func removeLayer(withName name: String) {
        guard let shapeLayer = layer.sublayers?.filter({ $0.name == name }).first, let position = layer.sublayers?.firstIndex(of: shapeLayer) else { return }
        
        layer.sublayers?.remove(at: position)
    }
    
}
