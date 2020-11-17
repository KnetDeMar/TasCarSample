//
//  BaseViewController.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import RxSwift
import CocoaLumberjack

class BaseViewController<VM: BaseViewModel>: UIViewController {
    
    // MARK: - Attributes
    
    var disposeBag = DisposeBag()
    var viewModel: VM!
    
    // MARK: - LifeCycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewModel = createViewModel()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Override and return a presenter in a subclass.
    func createViewModel() -> VM {
        DDLogError("  VMMV method `createViewModel()` must be override in a subclass and do not call `super.createViewModel()`!")
        preconditionFailure("VMMV method `createViewModel()` must be override in a subclass and do not call `super.createViewModel()`!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupLayout()
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.onViewWillAppear()
    }
    
    // MARK: - Setups
    
    /// Implements in child
    func setupLayout() { }
    
    func setupRx() {
        disposeBag = DisposeBag()
        
        viewModel.errorAction.elements.subscribe(onNext: { [weak self] formError in
            guard let self = self else { return }
            
            self.showAlert(error: formError)
        }).disposed(by: disposeBag)
    }
    
    func setupViewModel() {
        viewModel.setup(withPresenter: self)
    }
    
    // MARK: - Public methods
    
    func showAlert(title: String = "title".localized, message: String = "unknown".localized) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func showAlert(error: Error? = nil) {
        guard let error = error else { return }
        
        showAlert(message: error.localizedDescription)
    }
    
}
