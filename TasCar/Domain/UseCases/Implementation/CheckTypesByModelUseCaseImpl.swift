//
//  CheckTypesByModelUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 27/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class CheckTypesByModelUseCaseImpl: BaseUseCaseImpl<SourceRepository>, CheckTypesByModelUseCase {
    
    init() {
        super.init(repository: SourceRepositoryImpl())
    }
    
    // MARK: - Protocol implementation
    
    #if REALM
    
    func execute(withCar car: Car) -> Single<Bool> {
        return repository.retrieveTypes(withCar: car)
            .flatMap { cars -> Single<Bool> in
                return Single.just(cars.count != 1)
        }
    }
    
    #else
    
    func execute(withBrand brand: Brand, withCar car: Car) -> Single<Bool> {
        return repository.retrieveTypes(withBrand: brand, withCar: car)
            .flatMap { cars -> Single<Bool> in
                return Single.just(cars.count != 1)
        }
    }
    
    #endif
    
}
