//
//  CheckYearsByTypeModelUseCase.swift
//  TasCar
//
//  Created by Enrique Canedo on 27/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol CheckYearsByTypeModelUseCase {
    
    func execute(withCar car: Car) -> Single<Bool>
    
}
