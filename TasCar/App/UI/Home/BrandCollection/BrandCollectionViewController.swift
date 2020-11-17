//
//  BrandCollectionViewController.swift
//  TasCar
//
//  Created by Enrique Canedo on 15/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit

final class BrandCollectionViewController: BaseViewController<BrandCollectionViewModel>, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Constants
    
    private enum Constants {
        static let flowEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        static let numberOfCells: CGFloat = 4.0
        static let itemWidthPercentage: CGFloat = 1.0
    }
    
    // MARK: - Attributes UI
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Attributes
    
    private let brandListFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = Constants.flowEdgeInsets
        flowLayout.minimumLineSpacing = .zero
        flowLayout.minimumInteritemSpacing = .zero
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    override func createViewModel() -> BrandCollectionViewModel {
        return BrandCollectionViewModel()
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupItemSize()
    }
    
    // MARK: - Setups
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.brandModelList.asObservable().subscribe(onNext: { [weak self] _ in
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.reloadIndexPath.asObservable().subscribe(onNext: { [weak self] indexPathList in
            self?.collectionView.reloadItems(at: indexPathList)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Private setups
    
    private func setupItemSize() {
        let size = ((collectionView.frame.width - brandListFlowLayout.sectionInset.left - brandListFlowLayout.sectionInset.right) / Constants.numberOfCells).rounded(.down)
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
    
    // MARK: - Private methods
    
    private func registerCollectionCells() {
        BrandCollectionViewCell.register(collectionView: collectionView, cellClass: BrandCollectionViewCell.self)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.collectionViewLayout.invalidateLayout()
        return viewModel.numberOfRows(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = viewModel.cellIdentifier(indexPath: indexPath)
        if let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BrandCollectionViewCell,
            let viewModel = viewModel.cellViewModel(indexPath: indexPath) as? BrandCollectionViewCellModel {
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
