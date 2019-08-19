//
//  ImageRepositoryImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 18/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class ImageRepositoryImpl: ImageRepository {
    
    private let restAPI = AppGatewayImpl.shared
    private let carEntityDataMapper = CarEntityDataMapper()
    
    func searchImages(withQuery query: String) -> Single<CarImageEntity> {
        return restAPI.searchImage(withQuery: query)
    }
    
}
