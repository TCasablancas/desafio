//
//  ReposViewController.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

protocol ReposViewControllerDisplayLogic: class {
    func displayRepositories(viewModel: ReposModels.RepositoryView.ViewModel)
}

class ReposViewController: UIViewController {
    var presenter: ReposPresenter?
    var interactor: ReposInteractor?
    var worker: GithubWorker?
    var router: GithubRouter?
    var repository: [Repository] = []
    var selectedRepository: Repository?
    
    var total = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        setupConfig()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConfig()
    }
    
    private func setupConfig() {
        let viewController = self
        let presenter = ReposPresenter()
        let interactor = ReposInteractor()
        let router = GithubRouter()
        let worker = GithubWorker()
        
        viewController.presenter = presenter
        viewController.interactor = interactor
        viewController.worker = worker
        viewController.router = router
        viewController.collectionView = collectionView
        viewController.collectionViewCell = collectionViewCell
        
        presenter.viewController = viewController
        presenter.reposCollectionView = collectionView
        router.viewController = viewController
        router.dataStore = interactor
        
        ///Configuring Interactor Data
        interactor.viewController = viewController
        interactor.collectionView = collectionView
        interactor.collectionViewCell = collectionViewCell
        interactor.presenter = presenter
        interactor.worker = worker
        interactor.router = router
        
        ///Cofiguring Cell Data
        collectionView.viewController = viewController
        collectionView.interact = interactor
        collectionView.interactor = interactor
        collectionView.viewCell = collectionViewCell
        collectionViewCell.viewController = viewController
        collectionViewCell.repository = repository
        collectionView.worker = worker
    }
    
    //MARK: - UI
    lazy var container: BaseView = {
        let view = BaseView()
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [header, collectionView])
        stack.axis = .vertical
        return stack
    }()
    
    lazy var header: Header = {
        let view = Header()
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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        activity.style = .large
        activity.startAnimating()
        return activity
    }()
}

//MARK:

extension ReposViewController: ReposViewControllerDisplayLogic {
    func displayRepositories(viewModel: ReposModels.RepositoryView.ViewModel) {
        collectionViewCell.repoTitle.text = viewModel.name
        collectionViewCell.repoDescription.text = viewModel.description
    }
    
}


//MAKR: - UIComponents

extension ReposViewController: ViewCode {
    func viewHierarchy() {
        self.view.addSubview(container)
        self.view.addSubview(activityIndicator)
        container.addSubview(stackView)
    }

    func setupConstraints() {
        container.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                make.top.equalTo(window!.safeAreaInsets.top)
            }
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(100)
        }

        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(header.snp.bottom).inset(40)
            make.bottom.equalToSuperview()
        }
    }


}
