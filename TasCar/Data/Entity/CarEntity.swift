//
//  CarEntity.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

#if REALM

import RealmSwift

class CarEntity: Object {
    
    @objc dynamic var idCar: Int = 0
    @objc dynamic var brandString: String?
    @objc dynamic var model: String?
    @objc dynamic var type: String?
    @objc dynamic var year: String?
    @objc dynamic var price: Int = 0
    @objc dynamic var brand: BrandEntity?
    
    convenience init(idCar: Int, brand: String?, model: String?, type: String?, year: String?, price: Int) {
        self.init()
        
        self.idCar = idCar
        self.brandString = brand
        self.model = model
        self.type = type
        self.year = year
        self.price = price
    }
    
    override static func primaryKey() -> String? {
        return "idCar"
    }
    
}

#else

struct CarEntity: Decodable {
    
    let brand: String?
    let model: String?
    let type: String?
    let void: String?
    let year: String?
    let ccc: Int?
    let cil: String?
    let gdp: String?
    let cvf: Int?
    let price: Int?
    
}

#endif
