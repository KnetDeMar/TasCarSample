//
//  Car.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

final class Car: Equatable {
    
    #if REALM
    var brand: Brand = Brand()
    #else
    var brand: String = ""
    #endif
    var model: String = ""
    var type: String = ""
    var price: Int = 0
    var years: [Int] = [] 
    
    init() { }
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.model == rhs.model && lhs.brand == rhs.brand
    }
    
}
