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
    var interact: ReposInteractor?
    var viewController: ReposViewController?
    var viewCell: RepositoriesCollectionViewCell?
    var repository = [Repository]()
    var owner = [Owner]()
    var dataRepository: Repository?
    var dataOwner: Owner?
    var indexPath: IndexPath?
    
    var counting: Int?
    
    var worker: GithubWorker?
    private let cellIdentifier = "cell"
    
    init(interactor: ReposInteractor? = nil) {
        self.interact = interactor
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
//        return self.counting ?? 1
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! RepositoriesCollectionViewCell
        
        
        cell.delegate = self
        
        self.worker?.loadRepoList { (result) in
            switch result {
            case .success(let model):
                let repositories = model.items
                self.repository = repositories

                let index = indexPath.row
                let item = self.repository[index]
                let user = item.owner
                let userindex = user?[index]
                
                cell.username.text = userindex?.login

                self.counting = model.total_count
                
                cell.configureWith(with: item)
                
            case .serverError(let error):
                let errorData = "\(error.statusCode), -, \(error.msgError)"
                print("Server error: \(errorData) \n")
                break
            case .timeOut(let description):
                print("Server error noConnection: \(description) \n")
            case .noConnection(let description):
                print("Server error timeOut: \(description) \n")
            }
        }
//
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 130)
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
