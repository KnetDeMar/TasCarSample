//
//  TasCarBaseUITests.swift
//  TasCarUITests
//
//  Created by Enrique Republic on 03/10/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import XCTest

class TasCarBaseUITests: XCTestCase {
    
    internal var app: XCUIApplication = XCUIApplication() {
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
    
    func elementByButtonImageIdentifier(identifier: String) -> XCUIElement {
        return app.buttons[identifier]
    }
    
    func elementByCellWithImageIdentifier(identifier: String) -> XCUIElement {
        return app.collectionViews.cells.otherElements.containing(.image, identifier: ConstantsUITest.carBrandAbarth).element
    }
    
    func elementInPickerValue(identifier: String) {
        return app.pickerWheels.element.adjust(toPickerWheelValue: identifier)
    }

}
