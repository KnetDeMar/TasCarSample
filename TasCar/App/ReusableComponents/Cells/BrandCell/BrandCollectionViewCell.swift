//
//  BrandCollectionViewCell.swift
//  TasCar
//
//  Created by Enrique Canedo on 16/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift

final class BrandCollectionViewCell: BaseCollectionCellView<BrandCollectionViewCellModel> {
    
    // MARK: - Attributes UI
    
    @IBOutlet weak var brandImageView: UIImageView!
    
    // MARK: - Constants
    
    static let preferredHeight: CGFloat = 400.0
    
    // MARK: - LifeCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        brandImageView.image = nil
    }
    
    // MARK: - Setups
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.image.subscribe(brandImageView.rx.image).disposed(by: disposeBag)
        
        viewModel.selected.subscribe(onNext: { [weak self] selected in
            self?.corner(radius: Constants.radius)
            self?.layer.borderWidth = Constants.borderWidthDefault
            self?.layer.borderColor = selected ? self?.viewModel.cgColor : ThemeColor.transparent.cgColor
        }).disposed(by: disposeBag)
    }
    
}
