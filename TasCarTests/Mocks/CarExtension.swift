//
//  CarExtension.swift
//  TasCarTests
//
//  Created by Enrique Canedo on 27/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

extension Car {
    
    convenience init(brand: String, model: String) {
        self.init()
        
        self.brand = brand
        self.model = model
    }
    
    convenience init(price: Int) {
        self.init()
        
        self.price = price
    }
    
}
