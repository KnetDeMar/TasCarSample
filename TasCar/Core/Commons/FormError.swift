//
//  FormError.swift
//  TasCar
//
//  Created by Enrique Republic on 01/08/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

enum FormError: LocalizedError { 
    
    case emptyBrand, unknown
    
    var errorDescription: String? {
        switch self {
        case .emptyBrand:
            return "no_brand_selected".localized
        case .unknown:
            return "unknown".localized
        }
    }
    
}
