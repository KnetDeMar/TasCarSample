//
//  GetYearsByCarUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 27/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class GetYearsByCarUseCaseImpl: BaseUseCaseImpl<SourceRepository>, GetYearsByCarUseCase {
    
    init() {
        super.init(repository: SourceRepositoryImpl())
    }
    
    // MARK: - Protocol implementation
    
    func execute(withCar car: Car) -> Single<[Int]> {
        return Single.just(car.years)
    }
    
}
