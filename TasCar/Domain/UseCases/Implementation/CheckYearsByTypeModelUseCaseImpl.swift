//
//  CheckYearsByTypeModelUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 28/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class CheckYearsByTypeModelUseCaseImpl: BaseUseCaseImpl<SourceRepository>, CheckYearsByTypeModelUseCase {
    
    init() {
        super.init(repository: SourceRepositoryImpl())
    }
    
    // MARK: - Protocol implementation
    
    func execute(withCar car: Car) -> Single<Bool> {
        return Single.just(!car.years.isEmpty)
    }
    
}
