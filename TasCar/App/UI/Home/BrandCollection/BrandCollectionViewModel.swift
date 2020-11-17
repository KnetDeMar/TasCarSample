//
//  BrandCollectionViewModel.swift
//  TasCar
//
//  Created by Enrique Canedo on 15/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

final class BrandCollectionViewModel: BaseViewModel {
    
    // MARK: - Attributes
    
    private let brandModelDataMapper = BrandModelDataMapper()
    private let getBrandsUseCase = GetBrandsUseCaseImpl()
    private var selectRelay: BehaviorRelay<BrandModel?>?
    private var selectedItem: IndexPath?
    let brandModelList = BehaviorRelay<[BrandModel]>(value: [])
    let reloadIndexPath = BehaviorSubject<[IndexPath]>(value: [])
    
    // MARK: - LifeCycle
    
    override func onViewWillAppear() {
        super.onViewWillAppear()
        
        retrieveData()
    }
    
    // MARK: - Setups
    
    func setup(withSelectRelay selectRelay: BehaviorRelay<BrandModel?>?) {
        self.selectRelay = selectRelay
    }
    
    // MARK: - CollectionView values methods
    
    func numberOfRows(section: Int) -> Int {
        return brandModelList.value.count
    }
    
    func cellIdentifier(indexPath: IndexPath) -> String {
        return BrandCollectionViewCell.reuseIdentifier
    }
    
    func cellViewModel(indexPath: IndexPath) -> Any {
        let viewModel = BrandCollectionViewCellModel()
        viewModel.setup(withBrandModel: brandModelList.value[indexPath.row], selected: indexPath == selectedItem)
        return viewModel
    }
    
    func selectItemAt(_ indexPath: IndexPath) {
        guard selectedItem != indexPath else { return }
        
        var lastSelectionArray = [IndexPath]()
        if let lastSelection = selectedItem {
            lastSelectionArray = [lastSelection]
        }
        selectedItem = indexPath
        selectRelay?.accept(brandModelList.value[indexPath.row])
        reloadIndexPath.onNext([indexPath] + lastSelectionArray)
    }
    
    // MARK: - Private methods
    
    private func retrieveData() {
        _ = getBrandsUseCase.execute()
            .subscribeOn(RealmDataManager.shared.realmScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .success(let brands):
                    self?.brandModelList.accept(self?.brandModelDataMapper.transform(domainList: brands) ?? [])
                case .error: break
                }
            }.disposed(by: disposeBag)
    }
    
}
