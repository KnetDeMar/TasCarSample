//
//  BaseModelDataMapper.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

/// Base protocol with the available methods to transforms the classes
///
/// - Important:
/// To conform the protocol you need to implement the next methods:
///     - func transform(domain: InData) -> OutData?
///     - func transform(domainList: [InData]) -> [OutData]?
///     - func inverseTransform(domain: OutData?) -> InData
protocol BaseModelGenericDataMapper: BaseGenericDataMapper {
    
    /// Transform a object type InData into a object type OutData.
    ///
    /// - Parameters:
    ///     - domain: Object to be transformed
    /// - Returns: new OutData object
    func transform(domain: InData?) -> OutData
    
    /// Transform a object type [InData] into a object type [OutData].
    ///
    /// - Parameters:
    ///     - domain: Object to be transformed
    /// - Returns: new [OutData] object
    func transform(domainList: [InData]?) -> [OutData]
    
    /// Transform a object type OutData into a object type InData
    ///
    /// - Parameters:
    ///     - model: Object to be inverse transformed
    /// - Returns: new InData object
    func inverseTransform(model: OutData?) -> InData
    
}

// MARK: - Extension BaseDataMapper

extension BaseModelGenericDataMapper {
    
    func transform(domainList: [InData]?) -> [OutData] {
        guard let domainList = domainList else { return [] }
        
        return domainList.map { self.transform(domain: $0) }
    }
    
}

/// Class that implement the Protocol to transform the classes.
///
/// - Parameters:
///     - T: The parameter type out for the class
///     - E: The parameter type in for the class
class BaseModelDataMapper<T, E>: BaseGenericDataMapper {
    
    typealias InData = E
    typealias OutData = T
    
}
