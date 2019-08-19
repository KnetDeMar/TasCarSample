//
//  Network.swift
//  TasCar
//
//  Created by Enrique Canedo on 17/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Moya
import RxSwift

final class Network {

    static let shared = Network()
    
    private let provider = MoyaProvider<NetworkAPI>()
    
    func request<T: Decodable>(request: NetworkAPI, type: T.Type) -> Observable<T> {  
       return provider.rx.request(request)
        .retry(Connection.retries)
        .catchError { error in
            return .error(error)
        }
        .debug()
        .map(T.self)
        .asObservable()
    }
    
    func requestArray<T: Decodable>(request: NetworkAPI, type: T.Type) -> Observable<[T]> {
        return provider.rx.request(request)
            .retry(Connection.retries)
            .catchError { error in
                return .error(error)
            }
            .map([T].self)
            .asObservable()
    }
    
}
