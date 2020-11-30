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
    var interactor: ReposInteractor?
    var repository = [Repository]()
    var owner = [Owner]()
    var datarepo: Repository?
    var dataowner: Owner?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configureWith(with: datarepo, owner: dataowner)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureWith(with repository: Repository?, owner: Owner?) {
        self.datarepo = repository
        self.repoTitle.text = repository?.name
        self.repoDescription.text = repository?.description
//        self.username.text = owner?.login
    }
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.default.gray
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stackViewText, stackViewOwner])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var stackViewOwner: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imgContainer, username])
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var stackViewText: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [repoTitle, repoDescription, stackNumbers])
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var stackNumbers: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.axis = .horizontal
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
    
    private lazy var imgContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        return view
    }()
    
    public lazy var userPic: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
    }()
    
    public lazy var username: UILabel = {
        let label = UILabel()
        label.text = "Jon Doe"
        label.textAlignment = .center
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
        imgContainer.addSubview(userPic)
        
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(120)
        }
        
        stackView.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        stackViewText.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(stackViewOwner.snp.left)
        }
        
        stackViewOwner.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(90)
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
        
        imgContainer.snp.makeConstraints{ make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        userPic.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        username.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(imgContainer.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
    }
    
    
}
