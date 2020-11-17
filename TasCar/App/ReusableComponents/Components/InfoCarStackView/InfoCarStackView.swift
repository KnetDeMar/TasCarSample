//
//  InfoCarStackViewView.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

final class InfoCarStackView: BaseView {
    
    // MARK: - Attributes UI
    
    @IBOutlet private weak var infoStackView: UIStackView!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    // MARK: - ViewModel
    
    var viewModel = InfoCarStackViewModel()
    
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
        
        modelLabel.font = ThemeFont.bold22.font
        typeLabel.font = ThemeFont.normal20.font
        yearLabel.font = ThemeFont.normal17.font
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.color.subscribe(onNext: { [weak self] color in
            self?.view.backgroundColor = color
            self?.modelLabel.setup(withColor: color)
            self?.typeLabel.setup(withColor: color)
            self?.yearLabel.setup(withColor: color)
        }).disposed(by: disposeBag)
        
        viewModel.visible.subscribe(onNext: { [weak self] visible in
            self?.isHidden = !visible
        }).disposed(by: disposeBag)
        
        viewModel.carHelper.subscribe(onNext: { [weak self] helper in
            guard let helper = helper else { return }
          
            if let model = helper.model {
                self?.modelLabel.text = model
                self?.modelLabel.isHidden = model.isEmpty
            }
            if let type = helper.type {
                self?.typeLabel.text = type
                self?.typeLabel.isHidden = type.isEmpty
            } else {
                self?.typeLabel.isHidden = true
            }
            if let year = helper.year {
                self?.yearLabel.text = year
                self?.yearLabel.isHidden = year.isEmpty
            } else {
                self?.yearLabel.isHidden = true
            }
        }).disposed(by: disposeBag)
        
    }
    
}
