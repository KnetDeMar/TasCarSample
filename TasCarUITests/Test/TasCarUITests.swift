//
//  TasCarUITests.swift
//  TasCarUITests
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import XCTest

enum TasCarUIType {
    
    case brand, model, type, year, new
    
    var button: String {
        switch self {
        case .brand:
            return "select_brand".localized
        case .model:
            return "select_model".localized
        case .type:
            return "select_type".localized
        case .year:
            return "select_year".localized
        case .new:
            return "new".localized
        }
    }
    
    var identifier: String {
        switch self {
        case .brand:
            return ConstantsUITest.carBrandAbarth
        case .model:
            return ConstantsUITest.carModelAbarth
        case .type:
            return ConstantsUITest.carTypeAbarth
        case .year:
            return ConstantsUITest.carYearAbarth
        default:
            return ""
        }
    }
    
}

final class TasCarUITests: TasCarBaseUITests {
    
    lazy var acceptButton = app.buttons["ok".localized.uppercased()]
    
    func testShowPrivacy() {
        elementByButtonImageIdentifier(identifier: ConstantsUITest.infoIdentifier).tap()
        XCTAssertTrue(!app.windows.containing(.valueIndicator, identifier: ConstantsUITest.privacyView).element.exists, "Expected present privacy view but not load PrivacyView")
    }
    
    func testNoSelectionBrands() {
        app.buttons[TasCarUIType.brand.button.uppercased()].tap()
        acceptButton.tap()
        XCTAssertTrue(app.alerts.element.staticTexts["no_brand_selected".localized].exists, "Expected alert view with correctly message but not return")
    }
    
    func testSelectionChangeBrands() {
        app.buttons[TasCarUIType.brand.button.uppercased()].tap()
        elementByCellWithImageIdentifier(identifier: ConstantsUITest.carBrandAbarth).tap()
        elementByCellWithImageIdentifier(identifier: ConstantsUITest.carBrandAlpine).tap()
        elementByCellWithImageIdentifier(identifier: ConstantsUITest.carBrandAlfaRomeo).tap()
        acceptButton.tap()
    }
    
    func testFlowComplete() {
        selectButtonAndElement(type: TasCarUIType.brand)
        selectButtonAndElement(type: TasCarUIType.model)
        selectButtonAndElement(type: TasCarUIType.type)
        selectButtonAndElement(type: TasCarUIType.year)
        XCTAssertTrue(app.buttons[TasCarUIType.new.button.uppercased()].exists, "Expected button with new appraising value but received other")
    }
    
    // MARK: - Private functions
    
    private func selectButtonAndElement(type: TasCarUIType) {
        app.buttons[type.button.uppercased()].tap()
        if type == .brand {
            elementByCellWithImageIdentifier(identifier: type.identifier).tap()
        } else {
            elementInPickerValue(identifier: type.identifier)
        }
        acceptButton.tap()
    }
    
}
