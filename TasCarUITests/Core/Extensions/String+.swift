//
//  String+.swift
//  TasCarUITests
//
//  Created by Enrique Republic on 03/10/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation

extension String {
    
    /// Return localized string
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle(for: TasCarUITests.self), comment: "")
    }

}
