//
//  GetBrandsUseCase.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol GetBrandsUseCase {
    
    func execute() -> Single<[Brand]>
    
}
