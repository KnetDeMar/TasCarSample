//
//  PickerViewController.swift
//  TasCar
//
//  Created by Enrique Canedo on 15/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

final class PickerViewController: BaseViewController<PickerViewModel>, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet private weak var pickerView: UIPickerView!
    
    // MARK: - LifeCycle
    
    override func createViewModel() -> PickerViewModel {
        return PickerViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.carModelListFiltered.asObservable().subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.pickerView.reloadAllComponents()
        }).disposed(by: disposeBag)
        
        viewModel.carModelYearList.asObservable().subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.pickerView.reloadAllComponents()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Private setups
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectRow(row: row)
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfRowsInComponent()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.titlesForRow(row: row)
    }
    
}
