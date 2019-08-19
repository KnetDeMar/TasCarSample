//
//  CarModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

class CarModel: Equatable {
    
    #if REALM
    var brand: BrandModel = BrandModel()
    #else
    var brand: String = ""
    #endif
    var model: String = ""
    var type: String = ""
    var years: [Int] = []
    var price: Int = 0
    #if REALM
    lazy var query = "\(brand.name) \(model)"
    #else
    lazy var query = "\(brand) \(model)"
    #endif
    lazy var queryType = "\(query) \(type)"
    
    init() { }
    
    static func == (lhs: CarModel, rhs: CarModel) -> Bool {
        return lhs.model == rhs.model && lhs.brand == rhs.brand
    }
    
}
