//
//  RepoViewCell.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit

protocol RepositoriesCollectionViewCellDelegate {
    func routeToRepository()
}

class RepositoriesCollectionViewCell: UICollectionViewCell {
    var delegate: RepositoriesCollectionViewCellDelegate?
    var viewController: ReposViewController?
    var router: GithubRouter?
    var repository = [Repository]()
    var datarepo: Repository?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configureWith(repository)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureWith(_ repository: [Repository]) {
        let viewController = self
        self.repository = repository
        
        repoTitle.text = datarepo?.name
    }
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.default.gray
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [repoTitle, repoDescription])
        stack.axis = .vertical
        return stack
    }()
    
    public lazy var repoTitle: UILabel = {
        let label = UILabel()
        label.text = "Test Title"
        label.font = UIFont(name: "", size: 16)
        return label
    }()
    
    public lazy var repoDescription: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet..."
        return label
    }()
}

extension RepositoriesCollectionViewCell {
    func enterOwnerRepository() {
        delegate?.routeToRepository()
    }
}

extension RepositoriesCollectionViewCell: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
        container.addSubview(stackView)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(80)
        }
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        repoTitle.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        repoDescription.snp.makeConstraints { make in
            make.top.equalTo(repoTitle.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
}
