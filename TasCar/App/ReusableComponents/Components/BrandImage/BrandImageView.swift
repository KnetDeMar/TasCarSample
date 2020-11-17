//
//  BrandImageView.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

final class BrandImageView: BaseView {
    
    // MARK: - Attributes UI
    
    @IBOutlet weak var brandImageView: UIImageView!
    
    // MARK: - ViewModel
    
    var viewModel = BrandImageViewModel()
    
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
        
        brandImageView.superview?.corner()
        brandImageView.superview?.backgroundColor = ThemeColor.white.color
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.image.subscribe(onNext: { [weak self] image in
            self?.brandImageView.image = image
        }).disposed(by: disposeBag)
        
        viewModel.color.subscribe(onNext: { [weak self] color in
            guard let color = color else { return }
            
            self?.view.backgroundColor = color
        }).disposed(by: disposeBag)
        
    }
    
}
