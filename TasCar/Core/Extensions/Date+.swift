//
//  Date+.swift
//  TasCar
//
//  Created by Enrique Canedo on 22/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation

extension Date {
    
    /// Return the actual year 
    var yearFromDate: Int {
        return Calendar.current.dateComponents([.year], from: self).year ?? 0
    }
    
}
