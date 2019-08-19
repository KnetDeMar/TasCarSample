//
//  CarModelDataMapper.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

final class CarModelDataMapper: BaseModelDataMapper<CarModel, Car>, BaseModelGenericDataMapper {
    
    private let brandModelDataMapper = BrandModelDataMapper()
    
    func transform(domain: Car?) -> CarModel {
        if let domain = domain {
            let model = CarModel()
            model.model = domain.model
            #if REALM  
            model.brand = brandModelDataMapper.transform(domain: domain.brand)
            #else
            model.brand = domain.brand
            #endif
            model.type = domain.type
            model.years = domain.years
            model.price = domain.price
            return model
        }
        return CarModel()
    }
    
    func inverseTransform(model: CarModel?) -> Car {
        if let model = model {
            let domain = Car()
            domain.model = model.model
            #if REALM  
            domain.brand = brandModelDataMapper.inverseTransform(model: model.brand)
            #else
            domain.brand = model.brand
            #endif
            domain.type = model.type
            domain.years = model.years
            domain.price = model.price
            return domain
        }
        return Car()
    }
    
}
