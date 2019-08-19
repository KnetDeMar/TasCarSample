//
//  GetBrandsUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class GetBrandsUseCaseImpl: BaseUseCaseImpl<SourceRepository>, GetBrandsUseCase {
    
    init() {
        super.init(repository: SourceRepositoryImpl())
    }
    
    // MARK: - Protocol implementation
    
    func execute() -> Single<[Brand]> {
        return repository.retrieveBrands()
    }
    
}
