//
//  ReposViewController.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

class ReposViewController: UIViewController {
    var presenter: ReposPresenter?
    var interactor: ReposInteractor?
    var worker: GithubWorker?
    var repository: Repository?
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
        
        
        self.interactor?.getData()
        let nib = UINib(nibName: "RepositoriesCollectionViewCell", bundle: nil)
        self.collectionView.collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }   
    
    private func setupConfig() {
        let viewController = self
        let presenter = ReposPresenter()
        let interactor = ReposInteractor()
        let worker = GithubWorker()
        viewController.presenter = presenter
        viewController.interactor = interactor
        viewController.worker = worker
        interactor.viewController = viewController
        interactor.presenter = presenter
        interactor.worker = worker
        collectionView.viewController = viewController
        collectionView.interactor = interactor
        collectionView.viewCell = collectionViewCell
        collectionView.repository = repository
        viewController.collectionView = collectionView
    }
    
    //MARK: - UI
    lazy var container: BaseView = {
        let view = BaseView()
        return view
    }()
    
    lazy var collectionView: RepositoriesCollectionView = {
        let view = RepositoriesCollectionView()
        return view
    }()
    
    lazy var collectionViewCell: RepositoriesCollectionViewCell = {
        let cell = RepositoriesCollectionViewCell()
        return cell
    }()
}

//MARK:

extension ReposViewController {
    
}


//MAKR: - UIComponents

extension ReposViewController: ViewCode {
    func viewHierarchy() {
        self.view.addSubview(container)
        container.addSubview(collectionView)
    }

    func setupConstraints() {
        container.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }


}
