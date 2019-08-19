//
//  CarCardViewModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift
import RxCocoa
import Action
import Kingfisher

final class CarCardViewModel {
    
    private let imageDownloader = ImageDownloader(name: Constants.imageDownloaderTask)
    private let logoSizeDefault: CGFloat = 200.0
    let imageHeight = BehaviorSubject<ImageHeight?>(value: nil)
    let color = BehaviorRelay<Color>(value: ThemeColor.main.color)
    let loadingAction: ActionURL = Action { element in
        return Observable.create({ (observer) -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    var infoAction: CocoaAction?
    
    func setup(withUrl url: URL? = nil, withColor color: UIColor = ThemeColor.main.color, infoAction: CocoaAction) {
        imageDownloader.cancelAll()
        self.color.accept(color)
        self.infoAction = infoAction
        if let url = url {
            loadImage(withUrl: url, infoAction: infoAction)
        } else {
            imageHeight.onNext((image: ThemeImage.logo.image.fillAlpha(fillColor: color), height: logoSizeDefault))
        }
    }
    
    // MARK: - Public functions
    
    func tapOnInfo() {
        infoAction?.execute()
    }
    
    // MARK: - Private functions
    
    private func loadImage(withUrl url: URL, infoAction: CocoaAction) {
        createGifImage { [weak self] urlLoading in
            guard let self = self, let urlLoading = urlLoading else { return }
            
            self.loadingAction.execute(urlLoading)
            self.imageDownloader.downloadImage(with: url) { result in
                switch result {
                case .success(let image):
                    self.changeImage(image.image)
                case .failure:
                    self.setup(withColor: self.color.value, infoAction: infoAction)
                }
            }
        }
    }
    
    private func changeImage(_ image: UIImage) {
        imageHeight.onNext((image: image, height: nil))
    }
    
    private func createGifImage(completion: @escaping CompletionURL) {
        UIImage.animatedGif(withImages: Animation.layers.map { return UIImage(named: $0) ?? UIImage() }, fillColor: color.value, completion: completion)
    }
    
}
