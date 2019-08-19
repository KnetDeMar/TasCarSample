//
//  SourceRepositoryImpl.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class SourceRepositoryImpl: SourceRepository {
    
    private let brandEntityDataMapper = BrandEntityDataMapper()
    private let carEntityDataMapper = CarEntityDataMapper()
    
    #if REALM
    
    func retrieveBrands() -> Single<[Brand]> {
        return RealmDataManager.shared.list(type: BrandEntity.self)
            .map { brandListEntity in
                return self.brandEntityDataMapper.transform(entityList: brandListEntity)
        }
    }
    
    func retrieveCars(withBrand brand: Brand) -> Single<[Car]> {
        return RealmDataManager.shared.listCars(withBrand: brand)
            .map { carListEntity in
                return self.carEntityDataMapper.transform(entityList: carListEntity)
        }
    }
    
    func retrieveTypes(withCar car: Car) -> Single<[Car]> {
        return RealmDataManager.shared.listCars(withBrand: car.brand, withModel: car.model)
            .map { carListEntity in
                return self.carEntityDataMapper.transform(entityList: carListEntity)
        }
    }
    
    #else
    
    func retrieveBrands() -> Single<[Brand]> {
        return DataManager.shared.loadJson(type: BrandEntity.self, fileName: Files.fileBrands)
            .map { brandListEntity in
                return self.brandEntityDataMapper.transform(entityList: brandListEntity)
        }
    }
    
    func retrieveCars(withBrand brand: Brand) -> Single<[Car]> {
        return DataManager.shared.loadJson(type: CarEntity.self, fileName: brand.file)
            .map { carListEntity in
                return self.carEntityDataMapper.transform(entityList: carListEntity)
        }
    }
    
    func retrieveTypes(withBrand brand: Brand, withCar car: Car) -> Single<[Car]> {
        return retrieveCars(withBrand: brand).map { carList in 
            return carList.filter { $0 == car }
        }
    }
    
    #endif
    
}
