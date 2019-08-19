//
//  CheckBrandModelUseCase.swift
//  TasCar
//
//  Created by Enrique Republic on 14/08/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol CheckBrandModelUseCase {
    
    func execute(withBrand brand: Brand) -> Single<BrandModelCar>
    
}
