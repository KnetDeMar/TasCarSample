//
//  NetworkProxy.swift
//  TasCar
//
//  Created by Enrique Canedo on 18/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

open class NetworkProxy {
    
    public init() { }
    
    /// JSON
    
    /// Process a server call and parse the response as a JSON object
    ///
    /// - Important:
    ///     - Use it if you want to get a single object response "only one"
    ///     - If you use a flatmap or map the autocomplete will return a PrimitiveSecuence<T> and you will get errors change it with Single<T> and that's all :D
    /// - Parameters:
    ///     - networkService: the configuration to call the API
    ///     - type: use it to parse the object into the type of object that you want
    /// - Returns: a Single<T> object with the response
    func process<T: Decodable>(networkService: NetworkAPI, type: T.Type) -> Single<T> {
        return Network.shared.request(request: networkService, type: type).asSingle()
    }
    
    /// Process a server call and parse the response as a JSON object
    ///
    /// - Important:
    ///     Use it if you want to get a maybe object response "only one"
    /// - Parameters:
    ///     - networkService: the configuration to call the API
    ///     - type: use it to parse the object into the type of object that you want
    /// - Returns: a Maybe<T> object with the response
    func process<T: Decodable>(networkService: NetworkAPI, type: T.Type) -> Maybe<T> {
        return Network.shared.request(request: networkService, type: type).asMaybe()
    }
    
    /// Process a server call and parse the response as a JSON object
    ///
    /// - Important:
    ///     Use it if you want to get N objects response "multiples"
    /// - Parameters:
    ///     - networkService: the configuration to call the API
    ///     - type: use it to parse the object into the type of object that you want
    /// - Returns: a Observable<T> object with the response
    func process<T: Decodable>(networkService: NetworkAPI, type: T.Type) -> Observable<T> {
        return Network.shared.request(request: networkService, type: type)
    }
    
    /// ARRAY
    
    /// Process a server call and parse the response as a Array object
    /// 
    /// - Important:
    ///     - Use it if you want to get a single object response "only one"
    ///     - If you use a flatmap or map the autocomplete will return a PrimitiveSecuence<T> and you will get errors change it with Single<T> and that's all :D
    /// - Parameters:
    ///     - networkService: the configuration to call the API
    ///     - type: use it to parse the object into the type of object that you want
    /// - Returns: a Single<T> object with the response
    func processArray<T: Decodable>(networkService: NetworkAPI, type: T.Type) -> Single<[T]> {
        return Network.shared.requestArray(request: networkService, type: type).asSingle()
    }
    
    /// Process a server call and parse the response as a Array object
    ///
    /// - Important:
    ///     Use it if you want to get a single object response "only one"
    /// - Parameters:
    ///     - networkService: the configuration to call the API
    ///     - type: use it to parse the object into the type of object that you want
    /// - Returns: a Maybe<T> object with the response
    func processArray<T: Decodable>(networkService: NetworkAPI, type: T.Type) -> Maybe<[T]> {
        return Network.shared.requestArray(request: networkService, type: type).asMaybe()
    }
    
    /// Process a server call and parse the response as a Array object
    ///
    /// - Important:
    ///     Use it if you want to get N objects response "multiples"
    /// - Parameters:
    ///     - networkService: the configuration to call the API
    ///     - type: use it to parse the object into the type of object that you want
    /// - Returns: a Observable<T> object with the response
    func processArray<T: Decodable>(networkService: NetworkAPI, type: T.Type) -> Observable<[T]> {
        return Network.shared.requestArray(request: networkService, type: type)
    }
    
}
