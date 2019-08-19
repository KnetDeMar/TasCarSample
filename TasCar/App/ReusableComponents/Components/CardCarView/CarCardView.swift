//
//  CarCardViewView.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

final class CarCardView: BaseView {
    
    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var infoButton: UIButton!
    @IBOutlet private var carImageHeightConstraint: NSLayoutConstraint!
    
    var viewModel = CarCardViewModel()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupRx()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
        setupRx()
    }
    
    // MARK: - Setups
    
    override func setupLayout() {
        super.setupLayout()
        
        infoButton.setupByType(.info)
        infoButton.rounded()
    }
    
    override func setupRx() {
        super.setupRx()
        
        infoButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.tapOnInfo()
        }).disposed(by: disposeBag)
        
        viewModel.color.subscribe(onNext: { [weak self] color in 
            guard let self = self else { return }
            
            self.infoButton.setupByType(.info, withColor: color)
        }).disposed(by: disposeBag)
        
        viewModel.imageHeight.bind { [weak self] imageHeight in
            guard let self = self, let imageHeight = imageHeight, let imageProvider = imageHeight.image.imageProvider else { return }
            
            self.carImageView.kf.setImage(with: imageProvider)
            self.carImageHeightConstraint.constant = min((self.frame.width / imageHeight.image.size.width) * imageHeight.image.size.height, imageHeight.height ?? .greatestFiniteMagnitude)
        }.disposed(by: disposeBag)
        
        viewModel.loadingAction.elements.subscribe(onNext: { [weak self] url in
            guard let self = self, let url = url else { return }

            self.carImageView.kf.setImage(with: LocalFileImageDataProvider(fileURL: url))
        }).disposed(by: disposeBag)
        
    }
    
}
