//
//  DataManagerError.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

enum DataManagerError: LocalizedError {
    
    case invalidJson
    case invalidFile
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidFile:
            return "invalid_file".localized
        case .noData:
            return "data_empty".localized
        case .invalidJson:
            return "invalid_json".localized
        }
    }
    
}
