//
//  RealmDataManagerError.swift
//  TasCar
//
//  Created by Enrique Republic on 01/08/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

enum RealmDataManagerError: LocalizedError {
    
    case wrongFileConfig, unknown
    
    var errorDescription: String? {
        switch self {
        case .wrongFileConfig:
            return "wrong_file_config".localized
        case .unknown:
            return "unknown".localized
        }
    }
    
}
