//
//  PullRequestsVIewController.swift
//  GitRepo
//
//  Created by Thyago on 30/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

protocol PullRequestsDisplayLogic: class {
    
}

class PullRequestsViewController: UIViewController {
    private let interactor: PullRequestsInteractorBusinessLogic
    public lazy var pullRequests: [GithubModels.PullRequestView.ViewModel] = []
    
    private lazy var container: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        self.view.backgroundColor = Theme.default.gray
        interactor.getPullRequests()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init(interactor: PullRequestsInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PullRequestsViewController {
    private func setupNavigationBar() {
        let navigation = self.navigationController?.navigationBar
        
        title = "repotitle"
        navigation?.topItem?.backButtonTitle = ""
        navigation?.tintColor = Theme.default.description
    }
}

extension PullRequestsViewController: PullRequestsDisplayLogic {
    
}

extension PullRequestsViewController: ViewCode {
    func viewHierarchy() {
        self.view.addSubview(container)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    
}
