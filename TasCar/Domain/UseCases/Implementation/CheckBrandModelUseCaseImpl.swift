//
//  CheckBrandModelUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Republic on 14/08/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class CheckBrandModelUseCaseImpl: BaseUseCaseImpl<SourceRepository>, CheckBrandModelUseCase {
    
    init() {
        super.init(repository: SourceRepositoryImpl())
    }
    
    // MARK: - Protocol implementation
    
    func execute(withBrand brand: Brand) -> Single<BrandModelCar> {
        return repository.retrieveCars(withBrand: brand).flatMap { cars in
            guard cars.count >= 1 else { return Single.just((status: .none, car: nil)) }
            
            if cars.count == 1, let carFirst = cars.first {
                return Single.just((status: carFirst.years.isEmpty ? .only : .onlyWithYear, car: carFirst))
            }
            return Single.just((status: .normal, car: nil))
        }
    }
    
}
