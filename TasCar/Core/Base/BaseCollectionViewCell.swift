//
//  BaseCollectionViewCell.swift
//  TasCar
//
//  Created by Enrique Canedo on 16/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import RxSwift

class BaseCollectionCellView<VM>: UICollectionViewCell, BaseViewDelegate {
    
    var viewModel: VM!
    var disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
    }
    
    /// Override this function to setup the layout view
    func setupLayout() { }
    
    func setupRx() {
        disposeBag = DisposeBag()
    }
    
    func set(viewModel: VM) {
        self.viewModel = viewModel
        setupRx()
    }
    
    // MARK: - Static functions / properties
    
    static var reuseIdentifier: String {
        return String(describing: self.self)
    }
    
    static func register(collectionView: UICollectionView, cellClass: AnyClass) {
        let nibName = String(describing: cellClass.self)
        if !nibName.isEmpty {
            collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        } else {
            collectionView.register(cellClass, forCellWithReuseIdentifier: nibName)
        }
    }
    
}
