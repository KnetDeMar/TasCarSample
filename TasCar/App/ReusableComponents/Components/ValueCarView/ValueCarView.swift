//
//  ValueCarViewView.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation
import RxSwift

final class ValueCarView: BaseView {
    
    // MARK: - Attributes UI
    
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - ViewModel
    
    var viewModel = ValueCarViewModel()
    
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
        
        priceLabel.font = ThemeFont.bold29.font
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.color.bind(to: view.rx.backgroundColor).disposed(by: disposeBag)
        viewModel.price.bind(to: priceLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.color.subscribe(onNext: { [weak self] color in 
            self?.priceLabel.setup(withColor: color)
        }).disposed(by: disposeBag)
    }
    
}
