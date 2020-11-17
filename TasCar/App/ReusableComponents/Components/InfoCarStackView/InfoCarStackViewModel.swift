//
//  InfoCarStackViewModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

enum InfoCarType { case model, type, year, none }

final class InfoCarStackViewModel {
    
    // MARK: - Attributes
    
    let carHelper = BehaviorSubject<CarCardHelper?>(value: nil)
    let visible = BehaviorSubject<Bool>(value: false)
    let color = BehaviorSubject(value: ThemeColor.transparent.color)
    
    // MARK: - Setups
    
    func setup(withCarModel carModel: CarModel? = nil, withColor color: UIColor = ThemeColor.transparent.color, type: InfoCarType = .none, year: Int? = nil) {
        guard let carModel = carModel else { 
            clearCard()
            return 
        }
        
        visible.onNext(true)
        self.color.onNext(color)
        switch type {
        case .model:
            carHelper.onNext(CarCardHelper(model: carModel.model, type: "", year: ""))
        case .type:
            carHelper.onNext(CarCardHelper(model: carModel.model, type: carModel.type, year: ""))
        case .year:
            if let year = year {
                carHelper.onNext(CarCardHelper(model: carModel.model, type: carModel.type, year: String(year)))
            } else {
                carHelper.onNext(CarCardHelper(model: carModel.model, type: carModel.type, year: ""))
            }
        case .none:
            clearCard()
        }
    }
    
    // MARK: - Private methods
    
    private func clearCard() {
        carHelper.onNext(nil)
        visible.onNext(false)
    }

}
