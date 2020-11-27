//
//  ReposTableView.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

protocol RepositoriesCollectionViewPresentationLogic: class {
    func reload()
}

protocol RepositoriesCollectionViewInteractorLogic {
    func itemsCount() -> Int
}

class RepositoriesCollectionView: UIView {
    weak var interactor: ReposInteractor?
    var viewController: ReposViewController?
    var viewCell: RepositoriesCollectionViewCell?
    var repository: Repository?
    var selectedRepository: Repository? = nil
    private let cellIdentifier = "cell"
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    lazy var collectionView: UICollectionView = {
        let cell = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        cell.register(RepositoriesCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cell.showsVerticalScrollIndicator = false
        cell.showsHorizontalScrollIndicator = false
        cell.isPagingEnabled = true
        cell.delegate = self
        cell.dataSource = self
        cell.clipsToBounds = true
        cell.backgroundColor = Theme.default.white
        cell.layer.cornerRadius = 10
        return cell
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        return flow
    }()
}

//MARK: - CollectionViewDelegate Setup

extension RepositoriesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor?.itemsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? RepositoriesCollectionViewCell,
            let interact = interactor,
            let repository = interact.repository else { return UICollectionViewCell() }
        
        cell.delegate = self
        cell.configureWith(repository)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedRepository = self.repository?[indexPath[0].row]
//    }
}

//MARK: -

extension RepositoriesCollectionView: RepositoriesCollectionViewCellDelegate {
    func routeToRepository() {
        //
    }
    
    func reload() {
//        viewCell.reloadData()
    }
}

//MARK: - Setup UI

extension RepositoriesCollectionView: ViewCode {
    func viewHierarchy() {
        self.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(120)
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
    }
    
    
}
