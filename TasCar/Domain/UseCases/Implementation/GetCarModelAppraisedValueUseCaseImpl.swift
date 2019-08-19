//
//  GetCarModelAppraisedValueUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 25/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class GetCarModelAppraisedValueUseCaseImpl: BaseUseCaseImpl<CarRepository>, GetCarModelAppraisedValueUseCase {
    
    init() {
        super.init(repository: CarRepositoryImpl())
    }
    
    // MARK: - Protocol implementation
    
    func execute(withCar car: Car, yearSelected year: Int?) -> Single<Int> {
        return repository.retrieveValue(withCar: car, yearSelected: year)
    }

}
