//
//  ReposTableView.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

protocol ReposTableViewPresentationLogic: class {
    func reload()
}

class ReposTableView: UIView {
    weak var interactor: ReposInteractor?
    var viewCell: RepoViewCell?
    private let cellIdentifier = "cell"
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
}

extension ReposTableView: ReposTableViewPresentationLogic {
    func reload() {
//        viewCell.reloadData()
    }
}
