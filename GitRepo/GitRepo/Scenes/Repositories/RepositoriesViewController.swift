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
    lazy var container: BaseView = {
        let view = BaseView()
        return view
    }()
    
    lazy var header: Header = {
        let view = Header()
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [header, collectionView])
        stack.axis = .vertical
        return stack
    }()
    
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
    
    private let interactor: ReposInteractorBusinessLogic
    
    private lazy var repositories: [ReposModels.RepositoryView.ViewModel] = []
    
    var didSelect: (ReposModels.RepositoryView.ViewModel) -> Void = { _ in }
    
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
        self.navigationController?.navigationBar.topItem?.title = "gitrepo"
        self.navigationController?.navigationBar.backgroundColor = Theme.default.gray
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 24)!
        ]

        UINavigationBar.appearance().titleTextAttributes = attrs
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
}

// MARK: - RepositoriesCollectionViewCellDelegate Methods

extension RepositoriesViewController: RepositoriesCollectionViewCellDelegate {
    
    func routeToRepository(_ repository: ReposModels.RepositoryView.ViewModel) {
        didSelect(repository)
    }
}

// MARK: - ReposPresenterOutput Methods

extension RepositoriesViewController: ReposPresenterOutput {
    
    func displayStartLoading() {
        print("show activity indicator")
    }
    
    func displayRepositories(viewModel: [ReposModels.RepositoryView.ViewModel]) {
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
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            }
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}
