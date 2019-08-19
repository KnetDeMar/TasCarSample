//
//  SearchImagesByModelUseCaseImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 18/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class SearchImagesByModelUseCaseImpl: BaseUseCaseImpl<ImageRepository>, SearchImagesByModelUseCase {
    
    private let carImageEntityDataMapper = CarImageEntityDataMapper()
    
    init() {
        super.init(repository: ImageRepositoryImpl())
    }
    
    // MARK: - Protocol implementation
    
    func execute(withQuery query: String) -> Single<Media?> {
        return repository.searchImages(withQuery: query)
            .map { carImageEntity -> CarImage in
                return self.carImageEntityDataMapper.transform(entity: carImageEntity)
            }
            .flatMap { carImage -> Single<Media?> in
                return Single.just(carImage.images.first)
        }
    }
    
}
