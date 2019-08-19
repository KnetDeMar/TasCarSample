//
//  GetTypesByModelUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 23/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class GetTypesByModelUseCaseImpl: BaseUseCaseImpl<SourceRepository>, GetTypesByModelUseCase {
    
    init() {
        super.init(repository: SourceRepositoryImpl())
    }
    
    // MARK: - Protocol implementation
    
    #if REALM
    
    func execute(withCar car: Car) -> Single<[Car]> {
        return repository.retrieveTypes(withCar: car)
    }
    
    #else
    
    func execute(withBrand brand: Brand, withCar car: Car) -> Single<[Car]> {
        return repository.retrieveTypes(withBrand: brand, withCar: car)
    }
    
    #endif
    
}
