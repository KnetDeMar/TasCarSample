//
//  GetCarModelAppraisedValueUseCase.swift
//  TasCar
//
//  Created by Enrique Canedo on 25/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol GetCarModelAppraisedValueUseCase {
    
    func execute(withCar car: Car, yearSelected year: Int?) -> Single<Int>
    
}
