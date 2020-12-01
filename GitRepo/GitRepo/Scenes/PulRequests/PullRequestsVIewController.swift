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
    var interactor: PullRequestsInteractor?
    var worker: GithubWorker?
    
    
    private lazy var container: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConfig()
    }
    
    private func setupConfig() {
        let viewController = self
        let presenter = PullRequestsPresenter()
        let interactor = PullRequestsInteractor()
        let worker = GithubWorker()
        viewController.interactor = interactor
        viewController.worker = worker
        presenter.viewController = viewController
        interactor.worker = worker
        
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
