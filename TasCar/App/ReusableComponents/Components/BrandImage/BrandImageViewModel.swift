//
//  BrandImageViewModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class BrandImageViewModel {
    
    // MARK: - Attributes
    
    let image = BehaviorSubject<UIImage?>(value: nil)
    let color = BehaviorSubject<UIColor?>(value: nil)
    
    // MARK: - Setups
    
    func setup(withImage image: UIImage?) {
        self.image.onNext(image)
    }
    
    func setup(withColor color: UIColor?) {
        self.color.onNext(color)
    }
    
}
