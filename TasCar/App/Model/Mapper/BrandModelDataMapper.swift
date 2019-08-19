//
//  BrandModelDataMapper.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

final class BrandModelDataMapper: BaseModelDataMapper<BrandModel, Brand>, BaseModelGenericDataMapper {
    
    func transform(domain: Brand?) -> BrandModel {
        if let domain = domain {
            let model = BrandModel()
            model.idBrand = domain.idBrand
            model.name = domain.name
            if let image = UIImage(named: domain.image) {
                model.image = image
            }
            model.file = domain.file
            model.color = domain.color
            return model
        }
        return BrandModel()
    }
    
    func inverseTransform(model: BrandModel?) -> Brand {
        if let model = model {
            let domain = Brand()
            domain.idBrand = model.idBrand
            domain.file = model.file
            domain.name = model.name
            domain.color = model.color
            return domain
        }
        return Brand()
    }
    
}
