//
//  String+.swift
//  TasCar
//
//  Created by Enrique Canedo on 15/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation
import DynamicColor
import UIKit

extension String {
        
    /// Return localized string
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle.main, comment: "")
    }
    
    /// From string like YYYY-YYYY, YYYY-, -YYYY, YYYY convert to years with integer array
    var convertToYears: [Int] {
        guard range(of: #"^-?(19|20)\d{2}(-?(19|20)\d{2})?"#, options: .regularExpression) != nil else { return [] } 
        
        let splitValues = split(separator: Constants.yearSeparator)
        if hasPrefix(String(Constants.yearSeparator)), let firstValue = splitValues.first, let endYear = Int(firstValue) {
            return [endYear]
        } else if !hasSuffix(String(Constants.yearSeparator)), splitValues.count == 1, let firstValue = splitValues.first, let onlyYear = Int(firstValue) {
            return [onlyYear]
        } else if let firstValue = splitValues.first, let initialYear = Int(firstValue) {
            let finalYear = splitValues.count == 1 ? Date().yearFromDate : Int(splitValues[1]) ?? Date().yearFromDate
            return finalYear > initialYear ? finalYear <= Date().yearFromDate ? Array(initialYear...finalYear) : [] : []
        }
        return []
    }
    
    /// Return color from a six characters string
    var convertColor: DynamicColor {
        guard self.count == 6 else { return UIColor() }
        
        var rgbValue: UInt32 = 0
        Scanner(string: self).scanHexInt32(&rgbValue)
        return DynamicColor(cgColor: UIColor.rgb(rgbValue: rgbValue).cgColor)
    }
    
    /// Return url with secure protocol http
    var protocolHttps: String {
        guard !hasPrefix("https:") else { return self }
        
        return "https:\(self)"
    }
    
}
