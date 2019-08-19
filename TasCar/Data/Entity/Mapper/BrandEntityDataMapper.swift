//
//  BrandEntityDataMapper.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

final class BrandEntityDataMapper: BaseEntityDataMapper<Brand, BrandEntity>, BaseEntityGenericDataMapper {
    
    func transform(entity: BrandEntity?) -> Brand {
        if let entity = entity {
            let domain = Brand()
            #if REALM
            domain.idBrand = entity.idBrand
            #endif
            domain.name = entity.name ?? ""
            domain.image = entity.file ?? ""
            domain.file = entity.file ?? ""
            domain.color = entity.color?.convertColor ?? UIColor()
            return domain
        }
        return Brand()
    }
    
}
