//
//  TasCarUITests.swift
//  TasCarUITests
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import XCTest

class TasCarUITests: XCTestCase {
    
    var app: XCUIApplication = XCUIApplication() {
        didSet {
            app.launchArguments.append("--uitesting")    
        }
    }

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSelectorBrand() {
        
    }

}
