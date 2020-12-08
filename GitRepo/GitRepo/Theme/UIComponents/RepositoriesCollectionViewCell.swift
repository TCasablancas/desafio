//
//  RepoViewCell.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import FontAwesome_swift

protocol RepositoriesCollectionViewCellDelegate: AnyObject {
    func routeToRepository(_ repository: ReposModels.RepositoryView.ViewModel)
}

class RepositoriesCollectionViewCell: UICollectionViewCell {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = Theme.default.border.cgColor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = Theme.default.bgCell
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stackView, containerStackNumbers])
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stackViewText, ownerView])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var stackViewText: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [repoTitle, repoDescription])
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var stackNumbers: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [forks, stars])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var containerStackNumbers: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = Theme.default.border.cgColor
        view.backgroundColor = Theme.default.white
        return view
    }()
    
    private lazy var forks: CountingItem = {
        let view = CountingItem()
        view.icon.image = UIImage.fontAwesomeIcon(
            name: .codeBranch,
            style: .solid,
            textColor: Theme.default.description,
            size: CGSize(width: 12, height: 12))
        view.label.text = "Forks"
        return view
    }()
    
    private lazy var stars: CountingItem = {
        let view = CountingItem()
        view.icon.image = UIImage.fontAwesomeIcon(
            name: .star,
            style: .solid,
            textColor: Theme.default.description,
            size: CGSize(width: 12, height: 12))
        view.label.text = "Stargazers"
        return view
    }()
    
    private lazy var repoTitle: UILabel = {
        let label = UILabel()
        label.text = "Test Title"
        label.font = UIFont(name: "Roboto-Medium", size: 22.0)
        label.textColor = Theme.default.black
        return label
    }()
    
    private lazy var repoDescription: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet..."
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Regular", size: 14.0)
        label.textColor = Theme.default.description
        return label
    }()
    
    private lazy var ownerView: OwnerView = {
        let view = OwnerView()
        return view
    }()
    
    
    public weak var delegate: RepositoriesCollectionViewCellDelegate?
    
    private var repository: ReposModels.RepositoryView.ViewModel?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureWith(with repository: ReposModels.RepositoryView.ViewModel) {
        self.repository = repository
        
        DispatchQueue.main.async {
            self.repoTitle.text = repository.name
            self.repoDescription.text = repository.description
            self.forks.counter.text = repository.forks.flatMap(String.init)
            self.stars.counter.text = repository.stars.flatMap(String.init)
            self.ownerView.userPic.image = UIImage(named: "\(repository.avatar)")
            self.ownerView.username.text = repository.developer
            
            if let url = URL(string: repository.avatar ?? "") {
                self.ownerView.userPic.kf.indicatorType = .activity
                self.ownerView.userPic.kf.setImage(with: url)
            } else {
                self.ownerView.userPic.image = UIImage(named: "")
            }
        }
    }
}

extension RepositoriesCollectionViewCell {
    func enterOwnerRepository() {
        guard let repository = repository else { return }
        
        delegate?.routeToRepository(repository)
    }
}

extension RepositoriesCollectionViewCell: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
        container.addSubview(mainStackView)
        containerStackNumbers.addSubview(stackNumbers)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(10)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{ make in
            make.right.equalToSuperview().offset(-20)
            make.top.left.equalToSuperview()
            make.bottom.equalTo(stackNumbers.snp.top)
        }
        
        stackViewText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(ownerView.snp.left).offset(-10)
        }
        
        ownerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(100)
            make.right.equalToSuperview().offset(-20)
        }
        
        containerStackNumbers.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom)
        }
        
        stackNumbers.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        repoTitle.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        repoDescription.snp.makeConstraints { make in
            make.top.equalTo(repoTitle.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(70)
        }
        
        forks.snp.makeConstraints { make in
            make.width.equalTo(stars.snp.width)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
        stars.snp.makeConstraints { make in
            make.width.equalTo(forks.snp.width)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
    }
    
    
}
