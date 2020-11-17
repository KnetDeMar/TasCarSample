//
//  BaseWireframe.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

class BaseWireframe {
    
    enum DisplayMode { case present, push, root }
    
    weak var presenterViewController: UIViewController!
    
    func displayHome() {
        displayScreenMode(displayMode: .root, viewController: HomeViewController())
    }
    
    func displayWebView(type: WebViewType, color: UIColor? = nil) {
        guard let url = type.url else { return }
        
        let webViewController = WebViewController()
        webViewController.viewModel.setup(withURL: url, withColor: color)
        presenterViewController.present(webViewController, animated: true, completion: nil)
    }
    
    func popToRoot() {
        presenterViewController.navigationController?.popToRootViewController(animated: true)
    }
    
    func popViewController() {
        presenterViewController.navigationController?.popViewController(animated: true)
    }
    
    func dismissViewController() {
        presenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func displayScreenMode(displayMode: DisplayMode, viewController: UIViewController) {
        switch displayMode {
        case .present:
            presenterViewController.present(viewController, animated: true, completion: nil)
        case .push:
            guard let navigationController = presenterViewController.navigationController else { return }
                
            navigationController.pushViewController(viewController, animated: true)
        case .root:
            guard let window = UIApplication.shared.keyWindow else { return }
                
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
    }
    
}
