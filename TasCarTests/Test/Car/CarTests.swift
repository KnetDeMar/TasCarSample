//
//  DataTests.swift
//  DataTests
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import XCTest

final class CarTest: TasCarBaseTests {
    
    func testModelsByBrand() {
        do {
            let models = try GetModelByBrandUseCaseImpl()
                .execute(withFile: FilesTest.fileDefault)
                .toBlocking()
                .single()
            XCTAssert(!models.isEmpty, "Expected result car entities but received void")
        } catch let error {
            XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")
        }
    }
    
    func testModelsByErrorBrand() {
        XCTAssertThrowsError(try GetModelByBrandUseCaseImpl()
            .execute(withFile: FilesTest.fileNotExists)
            .toBlocking()
            .single(), "Expected result throw error, but received not throw")
    }
    
    func testTypesByModelAndBrand() {
        do {
            let car = Car(brand: ConstantsTest.carBrandDefault, model: ConstantsTest.carModelDefault)
            let types = try GetTypesByModelUseCaseImpl()
                .execute(withFile: FilesTest.fileDefault, withCar: car)
                .toBlocking()
                .single()
            XCTAssert(!types.isEmpty, "Expected result types by car default but received void")
        } catch let error {
            XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")
        }
    }
    
    func testNoTypesByModelAndBrand() {
        do {
            let car = Car(brand: ConstantsTest.carBrandDefault, model: ConstantsTest.noTypeModelDefault)
            let typesVoid = try CheckTypesByModelUseCaseImpl()
                .execute(withFile: FilesTest.fileDefault, withCar: car)
                .toBlocking()
                .single()
            XCTAssert(typesVoid, "Expected result only one type of car but received more")
        } catch let error {
            XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")
        }
    }
    
    func testNoTypesErrorByModelAndBrand() {
        do {
            let car = Car(brand: ConstantsTest.carBrandDefault, model: ConstantsTest.carModelDefault)
            let typesVoid = try CheckTypesByModelUseCaseImpl()
                .execute(withFile: FilesTest.fileDefault, withCar: car)
                .toBlocking()
                .single()
            XCTAssert(!typesVoid, "Expected result list of type with car but received minus")
        } catch let error {
            XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")
        }
    }
    
    func testAppraisedCarSameYear() {
        do {
            let car = Car(price: ConstantsTest.priceDefault)
            let received = try GetCarModelAppraisedValueUseCaseImpl()
                .execute(withCar: car, yearSelected: Date().yearFromDate)
                .toBlocking()
                .single()
            XCTAssertTrue(received == car.price, "Expected result the same price year but received \(received)")
        } catch let error {
            XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")    
        }
    }
    
    func testAppraisedCarErrorYear() {
        do {
            let car = Car(price: ConstantsTest.priceDefault)
            let received = try GetCarModelAppraisedValueUseCaseImpl()
                .execute(withCar: car, yearSelected: Date().yearFromDate + 1)
                .toBlocking()
                .single()
            XCTAssertTrue(received == 0, "Expected result the same price year but received \(received)")
        } catch let error {
            XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")    
        }
    }
    
    func testMeasure() {
        self.measure { }
    }
    
}
