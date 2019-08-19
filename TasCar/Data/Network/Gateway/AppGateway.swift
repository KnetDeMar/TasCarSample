//
//  AppGateway.swift
//  TasCar
//
//  Created by Enrique Canedo on 18/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol AppGateway {
       
    // MARK: - Get Images for Cars
    
    func searchImage(withQuery query: String) -> Single<CarImageEntity>

}
