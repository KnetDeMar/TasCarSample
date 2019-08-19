//
//  AppService.swift
//  TasCar
//
//  Created by Enrique Canedo on 18/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class AppService: NetworkProxy {

    // MARK: - Get Images for Cars
    
    func searchImage(withQuery query: String) -> Single<CarImageEntity> {
        return process(networkService: .search(query: query), type: CarImageEntity.self)
    }
    
}
