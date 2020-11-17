//
//  CarImageModelDataMapper.swift
//  TasCar
//
//  Created by Enrique Canedo on 19/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

final class CarImageModelDataMapper: BaseModelDataMapper<CarImageModel, CarImage>, BaseModelGenericDataMapper {
    
    func transform(domain: CarImage?) -> CarImageModel {
        guard let domain = domain else {
            return CarImageModel()
        }
        
        let model = CarImageModel()
        model.image = domain.images.first?.mediaFullSize
        return model
    }
    
    func inverseTransform(model: CarImageModel?) -> CarImage {
        return CarImage()
    }
    
}
