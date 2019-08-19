//
//  BrandCollectionViewController.swift
//  TasCar
//
//  Created by Enrique Canedo on 15/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

final class BrandCollectionViewController: BaseViewController<BrandCollectionViewModel>, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let flowEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    private let numberOfCells: CGFloat = 4.0
    private let brandListFlowLayout = UICollectionViewFlowLayout()
    private let itemWidthPercentage: CGFloat = 1.0
    
    override func createViewModel() -> BrandCollectionViewModel {
        return BrandCollectionViewModel()
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFlowLayout()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupItemSize()
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.brandModelList.asObservable().subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.reloadIndexPath.asObservable().subscribe(onNext: { [weak self] indexPathList in
            guard let self = self else { return }
            
            self.collectionView.reloadItems(at: indexPathList)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Private setups
    
    private func setupFlowLayout() {
        brandListFlowLayout.sectionInset = flowEdgeInsets
        brandListFlowLayout.minimumLineSpacing = CGFloat.zero
        brandListFlowLayout.minimumInteritemSpacing = CGFloat.zero
        brandListFlowLayout.headerReferenceSize = CGSize.zero
        brandListFlowLayout.footerReferenceSize = CGSize.zero
        brandListFlowLayout.scrollDirection = .vertical
        setupItemSize()
    }
    
    private func setupItemSize() {
        let size = ((collectionView.frame.width - brandListFlowLayout.sectionInset.left - brandListFlowLayout.sectionInset.right) / numberOfCells).rounded(.down)
        brandListFlowLayout.itemSize = CGSize(width: size, height: size)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = ThemeColor.transparent.color
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(brandListFlowLayout, animated: true)
        registerCollectionCells()
    }
    
    // MARK: - Private functions
    
    private func registerCollectionCells() {
        BrandCollectionViewCell.register(collectionView: collectionView, cellClass: BrandCollectionViewCell.self)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.collectionViewLayout.invalidateLayout()
        return viewModel.numberOfRows(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier(indexPath: indexPath), for: indexPath) as? BrandCollectionViewCell, let viewModel = viewModel.cellViewModel(indexPath: indexPath) as? BrandCollectionViewCellModel {
            collectionViewCell.set(viewModel: viewModel)
            return collectionViewCell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItemAt(indexPath)
    }
    
}
