//
//  WebViewController.swift
//  TasCar
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController<WebViewModel> {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var closeButton: UIButton!
    
    private let imageInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func createViewModel() -> WebViewModel {
        return WebViewModel()
    }
    
    // MARK: - LifeCycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: - Setups
    
    override func setupLayout() {
        super.setupLayout()
        
        closeButton.setTitle("", for: .normal)
        closeButton.imageEdgeInsets = imageInset
    }
    
    override func setupRx() {
        super.setupRx()
     
        closeButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.dismiss()
        }).disposed(by: disposeBag)
        
        viewModel.color.subscribe(onNext: { [weak self] color in
            guard let self = self else { return }
            
            self.closeButton.setImage(ThemeImage.close.image.fillAlpha(fillColor: color), for: .normal)
        }).disposed(by: disposeBag)
        
        viewModel.url.subscribe(onNext: { [weak self] url in
            guard let self = self, let url = url else { return }
            
            self.webView.load(URLRequest(url: url))
        }).disposed(by: disposeBag)
    }
    
}
