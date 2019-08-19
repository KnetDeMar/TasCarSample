//
//  Brand.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import DynamicColor

enum BrandStatusType { case normal, only, onlyWithYear, none }

final class Brand {
    
    var idBrand: Int = 0
    var name: String = ""
    var image: String = ""
    var file: String = ""
    var color: DynamicColor = DynamicColor()
    
    static func == (lhs: Brand, rhs: Brand) -> Bool {
        return lhs.idBrand == rhs.idBrand
    }
    
}
