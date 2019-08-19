//
//  HomeViewModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

enum HomeStateType: Int {
    
    case brand, brandSelection, model, modelSelection, type, typeSelection, year, yearSelection, result
    
    var title: String {
        switch self {
        case .brand:
            return "select_brand".localized
        case .model:
            return "select_model".localized
        case .type:
            return "select_type".localized
        case .year:
            return "select_year".localized
        case .brandSelection, .modelSelection, .typeSelection, .yearSelection:
            return "accept".localized
        case .result:
            return "new".localized
        }
    }
    
    var pickerViewController: PickerViewController? {
        switch self {
        case .modelSelection, .typeSelection, .yearSelection:
            return PickerViewController()
        default:
            return nil
        }
    }
    
    var brandViewController: BrandCollectionViewController? {
        switch self {
        case .brandSelection:
            return BrandCollectionViewController()
        default:
            return nil
        }
    }
    
    var nextState: HomeStateType {
        guard self != .result else { return .brand }
        
        return HomeStateType(rawValue: rawValue + 1) ?? .brand
    }
    
    var height: CGFloat {
        switch self {
        case .brandSelection:
            return 250.0
        case .modelSelection, .typeSelection, .yearSelection:
            return 216.0
        default:
            return CGFloat.zero
        }
    }
    
}

final class HomeViewModel: BaseViewModel {
    
    private let homeColorDefault = ThemeColor.main.color.lighter(amount: 0.5)
    private let searchImagesByModelUseCase = SearchImagesByModelUseCaseImpl()
    private let getCarModelAppraisedValueUseCase = GetCarModelAppraisedValueUseCaseImpl()
    private let checkTypesByModelUseCase = CheckTypesByModelUseCaseImpl()
    private let checkYearsByTypeModelUseCase = CheckYearsByTypeModelUseCaseImpl()
    private let checkBrandModelUseCase = CheckBrandModelUseCaseImpl()
    private let carModelDataMapper = CarModelDataMapper()
    private let brandModelDataMapper = BrandModelDataMapper()
    private var brandModel: BrandModel?
    let homeState = BehaviorRelay<HomeStateType>(value: .brand)
    let carModelRelay = BehaviorRelay<CarModel?>(value: nil)
    let yearRelay = BehaviorRelay<Int?>(value: nil)
    let selectBrandRelay = BehaviorRelay<BrandModel?>(value: nil)
    let carImageUrl = BehaviorSubject<URL?>(value: nil)
    let brandImage = BehaviorSubject<UIImage?>(value: nil)
    let value = BehaviorSubject(value: "")
    let infoAction = CocoaAction { return .empty() }
    lazy var homeColor = BehaviorSubject(value: homeColorDefault)
    var colorBrand: UIColor {
        guard let brandModel = brandModel else { return ThemeColor.main.color }
        
        return brandModel.color
    }
    
    func tapOnNextHomeState() {
        validate()
    }
    
    func selectedBrandModel() {
        guard let brandModel = selectBrandRelay.value else { return }
        
        self.brandModel = brandModel
        homeColor.onNext(brandModel.color.lighter(amount: 0.5))
        brandImage.onNext(brandModel.image)
    }
    
    func searchImage(withType type: Bool = false) {
        guard let carModel = carModelRelay.value else { return }
        
        _ = searchImagesByModelUseCase.execute(withQuery: type ? carModel.queryType : carModel.query)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let media):
                    self.carImageUrl.onNext(media?.mediaFullSize)
                case .error: break
                }
            }.disposed(by: disposeBag)
    }
    
    func calculatePrice() {
        guard let carModel = carModelRelay.value else { return }
        
        let car = carModelDataMapper.inverseTransform(model: carModel)
        _ = getCarModelAppraisedValueUseCase.execute(withCar: car, yearSelected: yearRelay.value)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let price):
                    self.value.onNext(price.currency)
                case .error: break
                }
            }.disposed(by: disposeBag)
    }
    
    func tapOnReStart() {
        homeState.accept(.brand)
    }
    
    func clear() {
        brandModel = nil
        homeColor.onNext(homeColorDefault)
        carModelRelay.accept(nil)
        yearRelay.accept(nil)
        selectBrandRelay.accept(nil)
        carImageUrl.onNext(nil)
        brandImage.onNext(nil)
        value.onNext("")
    }
    
    func interstitialDone() {
        homeState.accept(homeState.value.nextState)
    }
    
    func showInfo() {
        wireframe.displayWebView(type: .trademark, color: brandModel?.color)
    }
    
    // MARK: - Private functions
    
    private func validate() {
        do {
            try validateForm()
            switch homeState.value {
            case .brandSelection:
                checkIfHasModelsAndYears()
            case .modelSelection:
                checkIfHasTypeAndYears()
            case .typeSelection:
                checkIfHasYears()
            default: 
                homeState.accept(homeState.value.nextState)
            }
        } catch let error as FormError {
            errorAction.execute(error)
        } catch { }
    }
    
    private func validateForm() throws {
        switch homeState.value {
        case .brandSelection:
            guard selectBrandRelay.value != nil else {
                throw FormError.emptyBrand
            }
        default: break
        }
    }
    
    private func checkIfHasTypeAndYears() {
        guard let carModel = carModelRelay.value else { return }
        
        let car = carModelDataMapper.inverseTransform(model: carModel)
        
        #if REALM
        
        _ = Single.zip(checkTypesByModelUseCase.execute(withCar: car), checkYearsByTypeModelUseCase.execute(withCar: car))
            .subscribeOn(RealmDataManager.shared.realmScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let hasTypes, _) where hasTypes:
                    self.homeState.accept(.type)
                case .success(_, let hasYears) where hasYears:
                    self.homeState.accept(.year)
                case .success:
                    self.homeState.accept(.result)
                case .error: break
                }
            }.disposed(by: disposeBag)
        
        #else
        
        let brand = brandModelDataMapper.inverseTransform(model: brandModel)
        _ = Single.zip(checkTypesByModelUseCase.execute(withBrand: brand, withCar: car), checkYearsByTypeModelUseCase.execute(withCar: car))
            .subscribeOn(RealmDataManager.shared.realmScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let hasTypes, _) where hasTypes:
                    self.homeState.accept(.type)
                case .success(_, let hasYears) where hasYears:
                    self.homeState.accept(.year)
                case .success:
                    self.homeState.accept(.result)
                case .error: break
                }
            }.disposed(by: disposeBag)
        
        #endif
    }
    
    private func checkIfHasYears() {
        guard let carModel = carModelRelay.value else { return }
        
        let car = carModelDataMapper.inverseTransform(model: carModel)
        _ = checkYearsByTypeModelUseCase.execute(withCar: car)
            .subscribeOn(RealmDataManager.shared.realmScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let hasYears) where hasYears:
                    self.homeState.accept(.year)
                case .success:
                    self.homeState.accept(.result)
                case .error: break
                }
            }.disposed(by: disposeBag)
    }
    
    private func checkIfHasModelsAndYears() {
        guard let brandModel = selectBrandRelay.value else { return }
        
        let brand = brandModelDataMapper.inverseTransform(model: brandModel)
        _ = checkBrandModelUseCase.execute(withBrand: brand)
            .subscribeOn(RealmDataManager.shared.realmScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let modelStatus) where modelStatus.status == .onlyWithYear || modelStatus.status == .only:
                    self.carModelRelay.accept(self.carModelDataMapper.transform(domain: modelStatus.car))
                    self.homeState.accept(modelStatus.status == .onlyWithYear ? .year : .result)
                    self.selectedBrandModel()
                case .success:
                    self.homeState.accept(.model)
                case .error: break
                }
            }.disposed(by: disposeBag)
    }
    
}
