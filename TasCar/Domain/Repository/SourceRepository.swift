//
//  SourceRepository.swift
//  TasCar
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol SourceRepository {
    
    func retrieveBrands() -> Single<[Brand]>
    
    #if REALM
    
    func retrieveCars(withBrand brand: Brand) -> Single<[Car]>
    
    func retrieveTypes(withCar car: Car) -> Single<[Car]>
    
    #else 
    
    func retrieveCars(withBrand brand: Brand) -> Single<[Car]>
    
    func retrieveTypes(withBrand brand: Brand, withCar car: Car) -> Single<[Car]>
    
    #endif

}
