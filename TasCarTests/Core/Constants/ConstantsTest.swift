//
//  ConstantsTest.swift
//  TasCarTests
//
//  Created by Enrique Canedo on 27/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

// MARK: - Constants

enum ConstantsTest {
    
    static let priceDefault = 17_500
    static let carBrandDefault = "ABARTH"
    static let carBrandNokDefault = "ABARTHI"
    static let noTypeModelDefault = "Grande Punto"
    static let carModelDefault = "124"
    
}

// MARK: - File

enum FilesTest {
    
    static let fileNotExists = "lsldfjsdf"
    static let fileDefault = "abarth" 
    
}

// MARK: - Years

enum YearsValidate {
    
    static let validYearRange = "2001-2012"
    static let validYearInitial = "2001-"
    static let validYearFinal = "-2001"
    static let validYearOnly = "2010"
    static let invalidYearInitialRange = "20-1998"
    static let invalidYearRange = "2012-2010"
    static let invalidYearInitial = "22-"
    static let invalidYearFinal = "-22"
    static let invalidYearOnly = "20"
    
}
