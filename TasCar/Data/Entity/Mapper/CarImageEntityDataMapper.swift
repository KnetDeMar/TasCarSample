//
//  CarImageEntityDataMapper.swift
//  TasCar
//
//  Created by Enrique Canedo on 19/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation

final class CarImageEntityDataMapper: BaseEntityDataMapper<CarImage, CarImageEntity>, BaseEntityGenericDataMapper {
    
    func transform(entity: CarImageEntity?) -> CarImage {
        if let entity = entity {
            let domain = CarImage()
            domain.images = entity.data?.result.items.map { item in
                let image = Media()
                image.title = item.title
                image.type = item.type
                image.height = Int(item.height) ?? 0
                image.width = Int(item.width) ?? 0
                image.link = URL(string: item.url)
                image.media = URL(string: item.media)
                image.mediaFullSize = URL(string: item.mediaFull.protocolHttps)
                return image 
            } ?? []
            return domain
        }
        return CarImage()
    }
    
}
