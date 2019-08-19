//
//  Int+.swift
//  TasCar
//
//  Created by Enrique Canedo on 25/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation

extension Int {
    
    /// Return an integer with currency by default €
    var currency: String {
        guard let formatedValue = Constants.valueSeparator.string(for: self) else { return "" } 
        
        return "\(formatedValue) €*"
    }
    
}
