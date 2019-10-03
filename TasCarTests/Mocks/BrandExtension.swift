//
//  BrandExtension.swift
//  TasCarTests
//
//  Created by Enrique Republic on 03/10/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

extension Brand {
    
    convenience init(file: String) {
        self.init()
        
        self.file = file.lowercased()
    }
    
}
