//
//  UIViewController.swift
//  TasCar
//
//  Created by Enrique Canedo on 09/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Load a nib view for use in viewcontroller
    ///
    /// - Returns: View from Nib
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    /// Add a child ViewController to a parent ViewController through a ContainerView
    ///
    /// - Parameters:
    ///     - viewController : the child to be add it to the view
    ///     - containerView : the view that will hold the ViewController
    public func addChildViewController(withViewController viewController: UIViewController, withContainerView containerView: UIView) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.willMove(toParent: self)
        addChild(viewController)
        containerView.autoresizesSubviews = true
        containerView.addSubview(viewController.view)
        NSLayoutConstraint.activate([viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                                     viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                                     viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                                     viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)])
    }
    
    /// Remove a child ViewController to a parent ViewController through a ContainerView
    ///
    /// - Parameters:
    ///     - viewController : the child to be remove it from the view
    public func removeChildViewController(withViewController viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
}
