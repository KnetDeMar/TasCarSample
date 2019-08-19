//
//  BaseImageProvider.swift
//  TasCar
//
//  Created by Enrique Canedo on 26/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Kingfisher

struct BaseImageProvider: ImageDataProvider {
    
    var cacheKey: String {
        return String(data.hashValue)
    }
    let data: Data
    
    init(withImageData data: Data) {
        self.data = data
    }
    
    func data(handler: @escaping (Result<Data, Error>) -> Void) {
        handler(.success(data))
    } 
    
}
