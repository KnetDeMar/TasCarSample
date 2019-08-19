//
//  ViewController.swift
//  TasCar
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet private weak var containerCardShadowView: UIView!
    @IBOutlet private weak var brandImageView: BrandImageView!
    @IBOutlet private weak var containerShadowView: UIView!
    @IBOutlet private weak var containerCornerView: UIView!
    @IBOutlet private weak var containerCornerTopView: UIView!
    @IBOutlet private weak var selectionContainerView: UIView!
    @IBOutlet private weak var infoCarStackView: UIStackView!
    @IBOutlet private weak var carCardView: CarCardView!
    @IBOutlet private weak var valueCarView: ValueCarView!
    @IBOutlet private weak var infoCarView: InfoCarStackView!
    @IBOutlet private weak var selectionButton: UIButton!
    @IBOutlet private weak var reStartButton: UIButton!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var selectionContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var valueCarBottomConstraint: NSLayoutConstraint!
    
    override func createViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerCornerView.corner(corners: [.bottomLeft])
        containerCardShadowView.elevate(corners: [.bottomLeft], fillColor: viewModel.colorBrand.cgColor)
        valueCarView.corner(corners: [.bottomLeft])
        valueCarView.superview?.elevate(corners: [.bottomLeft])
        containerShadowView.elevate()
        containerCornerTopView.corner(corners: [.topRight])
    }
    
    // MARK: - Setups
    
    override func setupLayout() {
        super.setupLayout()
        
        selectionButton.setupSelection()
        reStartButton.setupByType(.reload)
        infoCarView.viewModel.setup()
        brandImageView.backgroundColor = ThemeColor.white.color
        infoLabel.text = "info".localized
        infoLabel.font = ThemeFont.normal17.font
        infoLabel.setup(inverse: true)
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.homeColor.bind(to: view.rx.backgroundColor).disposed(by: disposeBag)
        
        selectionButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.tapOnNextHomeState()
        }).disposed(by: disposeBag)
        
        reStartButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.tapOnReStart()
        }).disposed(by: disposeBag)
        
        viewModel.homeState.subscribe(onNext: { [weak self] homeState in
            guard let self = self else { return }
            
            if homeState == .brand {
                self.viewModel.clear()
            }
            self.selectionButton.setTitle(homeState.title.uppercased(), for: .normal)
            self.addContainerViewController(homeState)
        }).disposed(by: disposeBag)
        
        viewModel.brandImage.asObserver().subscribe(onNext: { [weak self] image in
            guard let self = self else { return }
            
            self.brandImageView.viewModel.setup(withImage: image)
            self.brandImageView.isHidden = image == nil
            self.infoCarStackView.isHidden = image == nil
            self.changeColor(self.viewModel.colorBrand)
        }).disposed(by: disposeBag)
        
        viewModel.carImageUrl.bind { [weak self] url in
            guard let self = self else { return }
            
            self.carCardView.viewModel.setup(withUrl: url, withColor: self.viewModel.colorBrand, infoAction: self.viewModel.infoAction)
        }.disposed(by: disposeBag)
        
        viewModel.value.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            
            self.valueCarView.viewModel.setup(withPrice: value, withColor: self.viewModel.colorBrand)
            value.isEmpty ? NSLayoutConstraint.activate([self.valueCarBottomConstraint]) : NSLayoutConstraint.deactivate([self.valueCarBottomConstraint])
            UIView.animate(withDuration: Constants.animationDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }).disposed(by: disposeBag)
        
        viewModel.infoAction.completions.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.showInfo()
        }).disposed(by: disposeBag)
        
    }
    
    // MARK: - Private functions
    
    private func addContainerViewController(_ homeState: HomeStateType) {
        animateSelectionContainer(withHeight: homeState.height) { finished in
            guard finished else { return }
            
            if homeState.pickerViewController != nil || homeState.brandViewController != nil {
                self.createViewController(homeState)
            } else {
                self.createNoViewController(homeState)
            } 
        }
    }
    
    private func animateSelectionContainer(withHeight height: CGFloat, completion: @escaping (Bool) -> Void) {
        selectionContainerHeightConstraint.constant = height
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.view.layoutIfNeeded()
        }, completion: completion)
    }
    
    private func createViewController(_ homeState: HomeStateType) {
        switch homeState {
        case .brandSelection:
            createBrandViewController(withHomeState: homeState)
        case .modelSelection, .typeSelection, .yearSelection:
            createPickerViewController(withHomeState: homeState)
        default: break
        }    
    }
    
    private func createNoViewController(_ homeState: HomeStateType) {
        infoLabel.isHidden = homeState != .result
        switch homeState {
        case .model:
            viewModel.selectedBrandModel()
        case .type:
            viewModel.searchImage()
            infoCarView.viewModel.setup(withCarModel: viewModel.carModelRelay.value, withColor: viewModel.colorBrand, type: .model)
        case .year:
            viewModel.searchImage(withType: true)
            infoCarView.viewModel.setup(withCarModel: viewModel.carModelRelay.value, withColor: viewModel.colorBrand, type: .type)
        case .result:
            viewModel.calculatePrice()
            infoCarView.viewModel.setup(withCarModel: viewModel.carModelRelay.value, withColor: viewModel.colorBrand, type: .year, year: viewModel.yearRelay.value)
        default: break
        }
        removeChildViewController(withViewController: children.first)
    }
    
    private func createBrandViewController(withHomeState homeState: HomeStateType) {
        guard let brandViewController = homeState.brandViewController else { return }
        
        brandViewController.viewModel.setup(withSelectRelay: viewModel.selectBrandRelay)
        addChildViewController(withViewController: brandViewController, withContainerView: selectionContainerView)
    }
    
    private func createPickerViewController(withHomeState homeState: HomeStateType) {
        guard let pickerViewController = homeState.pickerViewController else { return }
        
        switch homeState {
        case .modelSelection:
            pickerViewController.viewModel.setup(withType: .model(viewModel.selectBrandRelay.value), withCarRelay: viewModel.carModelRelay)
        case .typeSelection:
            pickerViewController.viewModel.setup(withType: .type(viewModel.selectBrandRelay.value, viewModel.carModelRelay.value), withCarRelay: viewModel.carModelRelay)
        case .yearSelection:
            pickerViewController.viewModel.setup(withType: .year(viewModel.carModelRelay.value), withYearRelay: viewModel.yearRelay)
        default: break
        }
        addChildViewController(withViewController: pickerViewController, withContainerView: selectionContainerView)
    }
    
    private func changeColor(_ color: UIColor) {
        selectionButton.setupSelection(withColor: color)
        reStartButton.setupByType(.reload, withColor: color)
        brandImageView.viewModel.setup(withColor: color)
        carCardView.viewModel.setup(withColor: color, infoAction: viewModel.infoAction)
        infoCarView.viewModel.setup(withColor: color)
    }
    
}
