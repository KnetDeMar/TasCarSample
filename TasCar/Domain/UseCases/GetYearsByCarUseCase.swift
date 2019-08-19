//
//  GetYearsByCarUseCase.swift
//  TasCar
//
//  Created by Enrique Canedo on 27/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol GetYearsByCarUseCase {
    
    func execute(withCar car: Car) -> Single<[Int]>
    
}
