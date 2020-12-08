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
        
        self.view.backgroundColor = Theme.default.gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension PullRequestsViewController {
    private func setupNavigationBar() {
        let appearance =  UINavigationBar.appearance()
        let navigation = self.navigationController?.navigationBar
        
        title = "reponame"
        navigation?.topItem?.backButtonTitle = ""
        navigation?.tintColor = Theme.default.description
        navigation?.backgroundColor = Theme.default.gray
        navigation?.shadowImage = UIImage()
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont(name: Font.poppinsBold.rawValue, size: 24)
        ]

        appearance.largeTitleTextAttributes = attrs
        
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
