//
//  BrandModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import DynamicColor

final class BrandModel {
    
    var idBrand: Int = 0
    var name: String = ""
    var image: UIImage = UIImage()
    var file: String = ""
    var color: DynamicColor = DynamicColor()
    
    static func == (lhs: BrandModel, rhs: BrandModel) -> Bool {
        #if REALM
        return lhs.idBrand == rhs.idBrand
        #else
        return lhs.name == rhs.name
        #endif
    }
    
}
