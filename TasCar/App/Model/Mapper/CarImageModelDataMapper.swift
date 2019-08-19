//
//  CarImageModelDataMapper.swift
//  TasCar
//
//  Created by Enrique Canedo on 19/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

final class CarImageModelDataMapper: BaseModelDataMapper<CarImageModel, CarImage>, BaseModelGenericDataMapper {
    
    func transform(domain: CarImage?) -> CarImageModel {
        if let domain = domain {
            let model = CarImageModel()
            model.image = domain.images.first?.mediaFullSize
            return model
        }
        return CarImageModel()
    }
    
    func inverseTransform(model: CarImageModel?) -> CarImage {
        return CarImage()
    }
    
}
