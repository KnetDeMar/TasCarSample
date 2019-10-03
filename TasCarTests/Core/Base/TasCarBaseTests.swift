//
//  TasCarBaseTests.swift
//  TasCarTests
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

class TasCarBaseTests: XCTestCase {
    
    internal var disposeBag = DisposeBag()
    
    override func setUp() {
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        
    }

}
