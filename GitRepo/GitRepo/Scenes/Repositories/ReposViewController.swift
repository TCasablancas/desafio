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
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor?.getData()

    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        setupConfig()
//        setup()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConfig()
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
