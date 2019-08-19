//
//  ValueCarViewModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class ValueCarViewModel {
    
    let color = BehaviorSubject(value: ThemeColor.main.color)
    let price = BehaviorSubject(value: "")
    
    func setup(withPrice price: String, withColor color: UIColor) {
        self.color.onNext(color)
        self.price.onNext(price)
    }

}
