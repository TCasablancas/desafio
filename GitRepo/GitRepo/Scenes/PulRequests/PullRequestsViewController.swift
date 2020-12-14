//
//  PullRequestsViewController.swift
//  GitRepo
//
//  Created by Thyago on 08/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RepositoriesCollectionViewCell"

class PullRequestsViewController: UICollectionViewController, PullRequestsCollectionViewCellDelegate {
    func routeToRepository(_ repository: GithubModels.PullRequestView.ViewModel) {
        routeToRepository(repository)
    }
    
    
    private let interactor: PullRequestsInteractorBusinessLogic
    public lazy var pullRequests: [GithubModels.PullRequestView.ViewModel] = []
    
    var name: String?
    var fullname: String?
    
    init(interactor: PullRequestsInteractor, name: String, fullname: String) {
        self.interactor = interactor
        self.name = name
        self.fullname = fullname
        
        GithubEndpoints.repo_name = fullname
        
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
        interactor.getPullRequests()
        configureCollectionView()
        setupNavigationBar()
    }
    
    private func configureCollectionView() {
        collectionView.register(PullRequestsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.backgroundColor = Theme.default.gray
    }
    
    private func setupNavigationBar() {
        let navigation = self.navigationController?.navigationBar
        
        title = self.fullname
        navigation?.topItem?.backButtonTitle = "início"
        navigation?.tintColor = Theme.default.description
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pullRequests.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PullRequestsCollectionViewCell
        
        let item = pullRequests[indexPath.item]
        cell.configureWith(with: item)
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
