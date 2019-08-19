//
//  CarEntityDataMapper.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

final class CarEntityDataMapper: BaseEntityDataMapper<Car, CarEntity>, BaseEntityGenericDataMapper {
    
    let brandEntityDataMapper = BrandEntityDataMapper()
    
    func transform(entity: CarEntity?) -> Car {
        if let entity = entity {
            let domain = Car()
            
            domain.model = entity.model ?? ""
            domain.type = entity.type ?? ""
            domain.years = entity.year?.convertToYears ?? []
            #if REALM
            domain.brand = brandEntityDataMapper.transform(entity: entity.brand)
            domain.price = entity.price
            #else
            domain.brand = entity.brand ?? ""
            domain.price = entity.price ?? 0
            #endif
            return domain
        }
        return Car()
    }
    
}
