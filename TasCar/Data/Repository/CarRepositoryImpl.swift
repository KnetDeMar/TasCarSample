//
//  CarRepositoryImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 25/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class CarRepositoryImpl: CarRepository {
    
    func retrieveValue(withCar car: Car, yearSelected year: Int?) -> Single<Int> {
        guard let year = year else { return Single.just(car.price) }
        
        return Single.just(Int(Double(car.price) * percentage(byYear: year)))
    }
    
    func retrieveYears(withCar car: Car) -> Single<[Int]> {
        return Single.just(car.years)
    }
    
    // MARK: - Private functions
    
    /// Function that return the percentage to subtract from the price total 
    ///
    /// - Parameters:
    ///     - byYears: Indicate years passed since car matriculation
    /// - Returns: Percentage to apply
    private func percentage(byYear year: Int) -> Double {
        switch Date().yearFromDate - year {
        case 0...1:
            return 1.0
        case 2:
            return 0.84
        case 3:
            return 0.67
        case 4:
            return 0.56
        case 5:
            return 0.47
        case 6:
            return 0.39
        case 7:
            return 0.34
        case 8:
            return 0.28
        case 9:
            return 0.24
        case 10:
            return 0.19
        case 11:
            return 0.17
        case 12:
            return 0.13
        case 12...Int.max:
            return 0.1
        default:
            return 0.0
        }
    }
    
}
