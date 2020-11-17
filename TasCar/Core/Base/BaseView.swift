//
//  BaseView.swift
//  TasCar
//
//  Created by Enrique Canedo on 15/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import RxSwift

class BaseView: UIView, BaseViewDelegate {
    
    // MARK: - Attributes UI
    
    @IBOutlet weak var view: UIView!
    
    // MARK: - Attributes
    
    var disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nibSetup()
        setupLayout()
        setupRx()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        nibSetup()
        setupLayout()
        setupRx()
    }
    
    // MARK: - Private methods
    
    private func nibSetup() {
        backgroundColor = UIColor.clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return nibView ?? UIView(frame: .zero)
    }
    
    // MARK: - Setups
    
    /// override this function to setup the layout view
    func setupLayout() { }
    
    func setupRx() {
        disposeBag = DisposeBag()
    }
    
}
