//
//  BaseEntityDataMapper.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

/// Base protocol with the available methods to transforms the classes
///
/// - Important:
/// To conform the protocol you need to implement the next methods:
///     - func transform(entity: InData) -> OutData?
///     - func transform(entityList: [InData]) -> [OutData]?
protocol BaseEntityGenericDataMapper: BaseGenericDataMapper {
    
    /// Transform a object type InData into a object type OutData.
    ///
    /// - Parameters:
    ///     - entity: Object to be transformed
    /// - Returns: new OutData object
    func transform(entity: InData?) -> OutData
    
    /// Transform a object type [InData] into a object type [OutData].
    ///
    /// - Parameters:
    ///     - entity: Object to be transformed
    /// - Returns: new [OutData] object
    func transform(entityList: [InData]?) -> [OutData]

}

// MARK: - Extension BaseDataMapper

extension BaseEntityGenericDataMapper {
    
    func transform(entityList: [InData]?) -> [OutData] {
        guard let entityList = entityList else { return [] }
        
        return entityList.map { self.transform(entity: $0) }
    }
    
}

/// Class that implement the Protocol to transform the classes.
///
/// - Parameters:
///     - T: The parameter type out for the class
///     - E: The parameter type in for the class
class BaseEntityDataMapper<T, E>: BaseGenericDataMapper {
    
    typealias InData = E
    typealias OutData = T
    
}
