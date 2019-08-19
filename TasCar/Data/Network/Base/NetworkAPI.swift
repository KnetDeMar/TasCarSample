//
//  NetworkAPI.swift
//  TasCar
//
//  Created by Enrique Canedo on 17/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Moya

enum NetworkAPI {
    
    case search(query: String)

}

extension NetworkAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.qwant.com/api")!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search/images"
        }
    }
    
    var method: Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        guard let parameters = parameters else { return .requestPlain}
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json", "User-Agent": "TasCar 1.0"]
    }
    
    var sampleData: Data {
        return Data()
    }
    
    // MARK: - Private properties
    
    private var parameters: [String: Any]? {
        switch self {
        case .search(let query):
            return ["count": "10", "q": query, "t": "images", "offset": "1", "uiv": "4"]
        }
    }
    
}
