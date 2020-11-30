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
    func items(at index: Int) -> Repository?
}

class RepositoriesCollectionView: UIView {
    var interactor: RepositoriesCollectionViewInteractorLogic?
    var dataInteract: ReposInteractor?
    var viewController: ReposViewController?
    var viewCell: RepositoriesCollectionViewCell?
    var repository: [Repository]?
    var dataRepository: Repository?
    private let cellIdentifier = "cell"
    
    init(interactor: ReposInteractor? = nil) {
        self.dataInteract = interactor
        super.init(frame: .zero)
        setup()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - UI
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.default.white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = Theme.default.facebook.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = .init(width: 0, height: 10)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let cell = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        cell.register(RepositoriesCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cell.showsVerticalScrollIndicator = false
        cell.showsHorizontalScrollIndicator = false
        cell.isPagingEnabled = true
        cell.delegate = self
        cell.dataSource = self
        cell.clipsToBounds = true
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 5
        cell.isUserInteractionEnabled = true
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
//        return interactor?.itemsCount() ?? 10
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! RepositoriesCollectionViewCell
        
        let interact = interactor
//        if let repository = interact?.items(at: indexPath.row) { return UICollectionViewCell() }
        
        cell.delegate = self
        cell.repoTitle.text = self.dataInteract?.title
        cell.configureWith(repository ?? [])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 90)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedRepository = self.repository?[indexPath[0].row]
//    }
}

//MARK: -

extension RepositoriesCollectionView: RepositoriesCollectionViewCellDelegate, RepositoriesCollectionViewPresentationLogic {
    func routeToRepository() {}
    
    func reload() {
        collectionView.reloadData()
    }
}


//MARK: - Setup UI

extension RepositoriesCollectionView: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
        container.addSubview(collectionView)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    
}