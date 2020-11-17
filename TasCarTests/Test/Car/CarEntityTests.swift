//
//  CarEntityTests.swift
//  TasCarTests
//
//  Created by Enrique Canedo on 27/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import XCTest

final class CarEntityTest: TasCarBaseTests {
    
    enum ComparisonType { case equal, greater }
    
    enum CarYearsTestType {
        
        case yearsValid, yearInitialValid, yearFinalValid, yearOnlyValid, yearInvalid, yearRangeInvalid, yearInitialRangeInvalid, yearFinalInvalid, yearOnlyInvalid
        
        var yearToTest: String {
            switch self {
            case .yearsValid:
                return YearsValidate.validYearRange
            case .yearInitialValid:
                return YearsValidate.validYearInitial
            case .yearFinalValid:
                return YearsValidate.validYearFinal
            case .yearOnlyValid:
                return YearsValidate.validYearOnly
            case .yearInvalid:
                return YearsValidate.invalidYearInitialRange
            case .yearRangeInvalid:
                return YearsValidate.invalidYearRange
            case .yearInitialRangeInvalid:
                return YearsValidate.invalidYearInitial
            case .yearFinalInvalid:
                return YearsValidate.invalidYearFinal
            case .yearOnlyInvalid:
                return YearsValidate.invalidYearOnly
            }
        }
        
        var isValid: Int {
            switch self {
            case .yearsValid:
                return 12
            case .yearInitialValid, .yearOnlyValid:
                return 1
            case .yearFinalValid, .yearInvalid, .yearRangeInvalid, .yearInitialRangeInvalid, .yearFinalInvalid, .yearOnlyInvalid:
                return 0
            }
        }
        
        var comparisonType: ComparisonType {
            switch self {
            case .yearsValid, .yearOnlyValid, .yearInvalid, .yearRangeInvalid, .yearInitialRangeInvalid, .yearFinalInvalid, .yearOnlyInvalid:
                return .equal
            case .yearInitialValid, .yearFinalValid:
                return .greater
            }
        }
        
    }
    
    func testYearsValid() {
        checkYears(withType: .yearsValid)
    }
    
    func testYearsOnlyInitialValid() {
        checkYears(withType: .yearInitialValid)
    }
    
    func testYearsOnlyFinalValid() {
        checkYears(withType: .yearFinalValid)
    }
    
    func testYearsOnlyOne() {
        checkYears(withType: .yearOnlyValid)
    }
    
    func testYearInvalid() {
        checkYears(withType: .yearInvalid)
    }
    
    func testYearRangeInvalid() {
        checkYears(withType: .yearRangeInvalid)
    }
    
    func testYearInitialRangeInvalid() {
        checkYears(withType: .yearInitialRangeInvalid)   
    }
    
    func testYearFinalInvalid() {
        checkYears(withType: .yearFinalInvalid)   
    }
    
    func testYearOnlyInvalid() {
        checkYears(withType: .yearOnlyInvalid)   
    }
    
    // MARK: - Private test methods
    
    private func checkYears(withType type: CarYearsTestType) {
        do {
            let carEntity = CarEntity(year: type.yearToTest)
            let car = CarEntityDataMapper().transform(entity: carEntity) 
            let years = try GetYearsByCarUseCaseImpl().execute(withCar: car)
                .toBlocking()
                .single()
            XCTAssert(type.comparisonType == .equal ? years.count == type.isValid : years.count > type.isValid, "Expected \(type.isValid) returned, but returns \(years.count)")
        } catch let error {
            XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")
        }
    }
    
}
