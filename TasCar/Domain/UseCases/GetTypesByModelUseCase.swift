//
//  GetTypesByModelUseCase.swift
//  TasCar
//
//  Created by Enrique Canedo on 23/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol GetTypesByModelUseCase {
    
    #if REALM
    
    func execute(withCar car: Car) -> Single<[Car]>
    
    #else
    
    func execute(withBrand brand: Brand, withCar car: Car) -> Single<[Car]>
    
    #endif
    
}
