//
//  GetModelsByBrandUseCase.swift
//  TasCar
//
//  Created by Enrique Canedo on 17/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol GetModelsByBrandUseCase {
    
    func execute(withBrand brand: Brand) -> Single<[Car]>
    
}
