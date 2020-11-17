//
//  BrandCollectionViewCellModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 16/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class BrandCollectionViewCellModel {

    // MARK: - Attributes
    
    let image = BehaviorSubject<UIImage?>(value: nil)
    let selected = BehaviorSubject<Bool>(value: false)
    var cgColor = ThemeColor.transparent.cgColor
    
    // MARK: - Setups
    
    func setup(withBrandModel brandModel: BrandModel, selected: Bool = false) {
        cgColor = brandModel.color.cgColor
        image.onNext(brandModel.image)
        self.selected.onNext(selected)
    }
    
}
