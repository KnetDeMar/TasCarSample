//
//  BaseUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

/// Base class to initialize the repository
///
/// - Parameters:
///     - T: The parameter type of the repository
class BaseUseCaseImpl<T> {
    
    internal let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
    
}
