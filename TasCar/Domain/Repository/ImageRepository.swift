//
//  ImageRepository.swift
//  TasCar
//
//  Created by Enrique Canedo on 18/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

protocol ImageRepository {
    
    func searchImages(withQuery query: String) -> Single<CarImageEntity>
    
}
