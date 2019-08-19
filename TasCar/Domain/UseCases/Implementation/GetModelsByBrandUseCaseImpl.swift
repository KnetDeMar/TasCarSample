//
//  GetModelByBrandUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 16/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class GetModelByBrandUseCaseImpl: BaseUseCaseImpl<SourceRepository>, GetModelsByBrandUseCase {
    
    init() {
        super.init(repository: SourceRepositoryImpl())
    }
    
    // MARK: - Protocol implementation
    
    func execute(withBrand brand: Brand) -> Single<[Car]> {
        return repository.retrieveCars(withBrand: brand)
    }
    
}
