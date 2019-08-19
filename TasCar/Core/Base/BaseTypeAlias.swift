//
//  BaseTypeAlias.swift
//  TasCar
//
//  Created by Enrique Canedo on 16/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Action

// MARK: - Actions

typealias ActionHomeState = Action<HomeStateType, HomeStateType>
typealias ActionURL = Action<URL?, URL?>
typealias ActionError = Action<FormError, FormError>

// MARK: - Shrink models

typealias ImageHeight = (image: UIImage, height: CGFloat?)
typealias CarCardHelper = (model: String?, type: String?, year: String?)
typealias BrandModelCar = (status: BrandStatusType, car: Car?)

// MARK: - Completions

typealias CompletionURL = (URL?) -> Void
