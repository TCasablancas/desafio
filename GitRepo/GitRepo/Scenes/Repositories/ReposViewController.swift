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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setup()
        
        self.view.layer.backgroundColor = Theme.default.orange.cgColor
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //MARK: - UI
    lazy var container: BaseView = {
        let view = BaseView()
        return view
    }()
    
    lazy var tableView: ReposTableView = {
        let view = ReposTableView()
        return view
    }()
}

extension ReposViewController: ViewCode {
    func viewHierarchy() {
        self.view.addSubview(container)
        container.addSubview(tableView)
    }

    func setupConstraints() {
        container.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(20)
            make.height.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }


}
