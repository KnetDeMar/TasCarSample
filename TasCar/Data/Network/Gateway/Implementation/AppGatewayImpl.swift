//
//  AppGatewayImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 18/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class AppGatewayImpl: AppGateway {

    static let shared = AppGatewayImpl()
    
    private let appService = AppService()
    
    private init() { }
    
    // MARK: - Protocol implementation
    
    func searchImage(withQuery query: String) -> Single<CarImageEntity> {
        return appService.searchImage(withQuery: query)
    }
    
}
