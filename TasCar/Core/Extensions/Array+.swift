//
//  Array+.swift
//  TasCar
//
//  Created by Enrique Canedo on 17/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

extension Array where Element: Equatable {
    
    /// Remove duplicates entries in Array
    var removeDuplicates: [Element] {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }    
        return result
    }
    
}
