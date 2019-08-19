//
//  DataTests.swift
//  DataTests
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import XCTest

final class DataTests: TasCarBaseTests {
    
    func testLoadDataExists() {
        do {
            let observable = try DataManager.loadData(fileName: Files.fileBrands)
            XCTAssertNotNil(observable.toBlocking().materialize())
        } catch let error {
            XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")
        }
    }
    
    func testLoadDataFileNoExists() {
        do {
            _ = try DataManager.loadData(fileName: FilesTest.fileNotExists)
            XCTFail("File don't should exists")
        } catch DataManagerError.invalidFile {
        } catch {
            XCTFail("Expected result to complete with error, but received \(DataManagerError.noData.localizedDescription)")
        }
    }
    
    func testLoadDataEmpty() {
        do {
            _ = try DataManager.loadData(fileName: Files.fileEmpty)
        } catch DataManagerError.noData { 
        } catch {
            XCTFail("Expected result to complete with error, but received \(DataManagerError.invalidFile.localizedDescription)")
        }
    }
    
    func testLoadJsonBrands() {
        DataManager.loadJson(type: BrandEntity.self, fileName: Files.fileBrands).subscribe { event in
            switch event {
            case .success: break
            case .error(let error):
                XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")    
            }
        }.disposed(by: disposeBag)
    }
    
    func testLoadFilesBrand() {
        do {
            let brands = try DataManager.loadJson(type: BrandEntity.self, fileName: Files.fileBrands)
                .toBlocking()
                .single()
            try brands.forEach { brand in
                _ = try DataManager.loadData(fileName: brand.file)
            }
        } catch let error {
            XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")
        }
    }
    
    func testLoadJsonBrand() {
        DataManager.loadJson(type: BrandEntity.self, fileName: Files.fileBrands).subscribe { event in
            switch event {
            case .success(let brands):
                brands.forEach { brand in
                    _ = self.checkLoadCarsJsonByBrand(file: brand.file)
                }
            case .error(let error):
                XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")    
            }
        }.disposed(by: disposeBag)
    }
    
    func testMeasure() {
        self.measure { }
    }
    
    // MARK: - Private functions
    
    private func checkLoadCarsJsonByBrand(file: String) {
        DataManager.loadJson(type: CarEntity.self, fileName: file).subscribe { event in
            switch event {
            case .success: break 
            case .error(let error):
                XCTFail("Expected result to complete without error, but received \(error.localizedDescription)")    
            }
        }.disposed(by: disposeBag)
    }
    
}
