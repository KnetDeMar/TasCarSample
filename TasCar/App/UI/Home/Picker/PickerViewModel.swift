//
//  PickerViewModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 15/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

enum PickerViewType {
    
    case model(BrandModel?)
    case type(BrandModel?, CarModel?)
    case year(CarModel?)
    case unknown
    
    var file: String? {
        switch self {
        case .model(let brandModel), .type(let brandModel, _):
            return brandModel?.file
        default:
            return nil
        }
    }
    
    var brandModel: BrandModel? {
        switch self {
        case .model(let brandModel), .type(let brandModel, _):
            return brandModel
        default:
            return nil
        }
    }
    
    var carModel: CarModel? {
        switch self {
        case .type(_, let carModel?), .year(let carModel?):
            return carModel
        default: 
            return nil
        }
    }
    
}

final class PickerViewModel: BaseViewModel {
    
    private let getModelByBrandUseCase = GetModelByBrandUseCaseImpl()
    private let getTypesByModelUseCase = GetTypesByModelUseCaseImpl()
    private let getYearsByCarUseCase = GetYearsByCarUseCaseImpl()
    private let brandModelDataMapper = BrandModelDataMapper()
    private let carModelDataMapper = CarModelDataMapper()
    private var type = PickerViewType.unknown
    private var carModelList = [CarModel]()
    private var carModelRelay: BehaviorRelay<CarModel?>?
    private var yearRelay: BehaviorRelay<Int?>?
    let numberOfComponents: Int = 1
    let carModelListFiltered = BehaviorRelay<[CarModel]>(value: [])
    let carModelYearList = BehaviorRelay<[Int]>(value: [])
    
    // MARK: - Setups
    
    func setup(withType type: PickerViewType, withCarRelay carModelRelay: BehaviorRelay<CarModel?>? = nil, withYearRelay yearRelay: BehaviorRelay<Int?>? = nil) {
        self.type = type
        self.carModelRelay = carModelRelay
        self.yearRelay = yearRelay
        retrieveData()
    }
    
    // MARK: - PickerView values methods
    
    func numberOfRowsInComponent () -> Int {
        switch type {
        case .year:
            return carModelYearList.value.count
        default:
            return carModelListFiltered.value.count
        }
    }
    
    func titlesForRow(row: Int) -> String {
        switch type {
        case .model:
            return carModelListFiltered.value[row].model    
        case .type:
            return carModelListFiltered.value[row].type
        case .year:
            return "\(carModelYearList.value[row])"
        default:
            return ""
        }
    }
    
    func selectRow(row: Int) {
        switch type {
        case .year:
            guard let yearRelay = yearRelay else { return }
            
            yearRelay.accept(carModelYearList.value[row])
        default:
            guard let carModelRelay = carModelRelay else { return }
            
            carModelRelay.accept(carModelListFiltered.value[row])
        }
    }
    
    // MARK: - Private functions
    
    private func retrieveData() {
        switch type {
        case .model:
            retrieveDataModels()
        case .type:
            retrieveDataTypes()
        case .year:
            retrieveDataYears()
        default: break
        }
    }
    
    private func retrieveDataModels() {
        guard let brandModel = type.brandModel else { return }
        
        let brand = brandModelDataMapper.inverseTransform(model: brandModel)
        _ = getModelByBrandUseCase.execute(withBrand: brand)
            .subscribeOn(RealmDataManager.shared.realmScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let cars): 
                    self.carModelList = self.carModelDataMapper.transform(domainList: cars)
                    self.carModelListFiltered.accept(self.carModelList.removeDuplicates)
                    if let firstCarModel = self.carModelListFiltered.value.first { 
                        self.carModelRelay?.accept(firstCarModel)
                    }
                case .error: break
                }
            }.disposed(by: disposeBag)
    }
    
    private func retrieveDataTypes() {
        guard let brandModel = type.brandModel, let carModel = type.carModel else { return }
        
        let car = carModelDataMapper.inverseTransform(model: carModel)
        
        #if REALM
        
        _ = getTypesByModelUseCase.execute(withCar: car)
            .subscribeOn(RealmDataManager.shared.realmScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let cars):
                    self.carModelListFiltered.accept(self.carModelDataMapper.transform(domainList: cars))
                    if let firstCarModel = self.carModelListFiltered.value.first { 
                        self.carModelRelay?.accept(firstCarModel)
                    }
                case .error: break
                }
            }.disposed(by: disposeBag)
        
        #else
        
        let brand = brandModelDataMapper.inverseTransform(model: brandModel)
        _ = getTypesByModelUseCase.execute(withBrand: brand, withCar: car)
            .subscribeOn(RealmDataManager.shared.realmScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let cars):
                    self.carModelListFiltered.accept(self.carModelDataMapper.transform(domainList: cars))
                    if let firstCarModel = self.carModelListFiltered.value.first { 
                        self.carModelRelay?.accept(firstCarModel)
                    }
                case .error: break
                }
            }.disposed(by: disposeBag)
        
        #endif
    }
    
    private func retrieveDataYears() {
        guard let carModel = type.carModel else { return }
        
        let car = carModelDataMapper.inverseTransform(model: carModel)
        _ = getYearsByCarUseCase.execute(withCar: car)
            .subscribeOn(RealmDataManager.shared.realmScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let years):
                    self.carModelYearList.accept(years) 
                    if let firstYear = years.first {
                        self.yearRelay?.accept(firstYear)
                    }
                case .error: break
                }
            }.disposed(by: disposeBag)
    }
        
}
