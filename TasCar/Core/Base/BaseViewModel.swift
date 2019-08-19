//
//  BaseViewModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift
import Action

class BaseViewModel {
    
    let wireframe = BaseWireframe()
    let errorAction: ActionError = Action { element in
        return Observable.create({ (observer) -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    var disposeBag = DisposeBag()
    
    // MARK: - Setups
    
    func setup(withPresenter presenter: UIViewController) {
        wireframe.presenterViewController = presenter
    }
    
    /// Override this method if you want to do something in the viewWillAppear of the ViewController
    func onViewWillAppear() { }
    
}
