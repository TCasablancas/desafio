//
//  ReposVC.swift
//  GitRepo
//
//  Created by Thyago on 08/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit
import FontAwesome_swift

private let reuseIdentifier = "RepositoriesCollectionViewCell"

class RepositoriesViewController: UICollectionViewController {
    
    //MARK: - UI

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        activity.style = .large
        activity.startAnimating()
        return activity
    }()
    
    lazy var btnMenu: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage.fontAwesomeIcon(
            name: .star,
            style: .solid,
            textColor: Theme.default.description,
            size: CGSize(width: 12, height: 12))
        return button
    }()
    
    private let interactor: RepositoriesInteractorBusinessLogic
    public lazy var repositories: [GithubModels.RepositoryView.ViewModel] = []
    
    var didSelect: (GithubModels.RepositoryView.ViewModel) -> Void = { _ in }
    
    init(interactor: ReposInteractor) {
        self.interactor = interactor
        
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        
        super.init(collectionViewLayout: flow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        interactor.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func configureCollectionView() {
        collectionView.register(RepositoriesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.backgroundColor = Theme.default.gray
    }

    private func setupNavigationBar() {
        let navigation = self.navigationController?.navigationBar
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigation?.prefersLargeTitles = true
        navigation?.topItem?.title = "gitrepo"
        navigation?.backgroundColor = Theme.default.gray
        navigation?.shadowImage = UIImage()
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont(name: Font.poppinsBold.rawValue, size: 24)
        ]

        UINavigationBar.appearance().titleTextAttributes = attrs
        
        for view in self.navigationController?.navigationBar.subviews ?? [] {
             let subviews = view.subviews
             if subviews.count > 0, let label = subviews[0] as? UILabel {
                label.textColor = Theme.default.description
             }
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repositories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RepositoriesCollectionViewCell
        
        let item = repositories[indexPath.item]
        cell.configureWith(with: item)
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = repositories[indexPath.item]
        self.routeToRepository(item)
        
        let presenter = PullRequestsPresenter()
        let ainteracor = PullRequestsInteractor(output: presenter, worker: GithubWorker())
        
        guard
            let name = item.name,
            let url = item.full_name else { return }
        
        self.navigationController?.pushViewController(
            PullRequestsViewController(interactor: ainteracor, name: name, fullname: url), animated: true)
    }
}

// MARK: - RepositoriesCollectionViewCellDelegate Methods

extension RepositoriesViewController: RepositoriesCollectionViewCellDelegate {
    
    func routeToRepository(_ repository: GithubModels.RepositoryView.ViewModel) {
        didSelect(repository)
    }
}

// MARK: - ReposPresenterOutput Methods

extension RepositoriesViewController: RepositoriesPresenterOutput {
    func displayStartLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func displayRepositories(viewModel: [GithubModels.RepositoryView.ViewModel]) {
        repositories = viewModel
        collectionView.reloadData()
    }
    
    func displayError(error: String) {
        print(error)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods

extension RepositoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 160)
    }
}

extension RepositoriesViewController: ViewCode {
    func viewHierarchy() {
        self.view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        
    }
}
