//
//  WebViewModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift
import Action

enum WebViewType {
    
    case trademark, custom(URL), unknown
    
    var url: URL? {
        switch self {
        case .trademark:
            return URL(string: Constants.privacyUrl)
        case .custom(let url):
            return url
        default: return nil
        }
    }
    
}

final class WebViewModel: BaseViewModel {
    
    let color = BehaviorSubject(value: ThemeColor.main.color)
    let url = BehaviorSubject<URL?>(value: nil)
    
    func setup(withURL url: URL, withColor color: UIColor? = ThemeColor.main.color) {
        if let color = color {
            self.color.onNext(color)
        }
        self.url.onNext(url)
    }
    
    func dismiss() {
        wireframe.dismissViewController()
    }
    
}
