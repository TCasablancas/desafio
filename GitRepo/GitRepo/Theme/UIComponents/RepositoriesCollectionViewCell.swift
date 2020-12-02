//
//  RepoViewCell.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit
import FontAwesome_swift

protocol RepositoriesCollectionViewCellDelegate {
    func routeToRepository()
}

class RepositoriesCollectionViewCell: UICollectionViewCell {
    var delegate: RepositoriesCollectionViewCellDelegate?
    var viewController: ReposViewController?
    var presenter: ReposPresenter?
    var router: GithubRouter?
    var interactor: ReposInteractor?
    var repository: [Repository] = []
    var owner = [Owner]()
    var datarepo: Repository?
    var dataowner: Owner?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configureWith(with: datarepo)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureWith(with repository: Repository?) {
        self.datarepo = repository
        guard
            let forks = repository?.forks_count,
            let stars = repository?.stargazers_count else { return }
        
        DispatchQueue.main.async {
            self.repoTitle.text = repository?.name
            self.repoDescription.text = repository?.description
            self.numberForks.text = String(forks)
            self.numberStars.text = String(stars)
        }
    }
    
    public lazy var container: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = Theme.default.border.cgColor
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
        let stack = UIStackView(arrangedSubviews: [forksStack, starsStack])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var forksStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [forkIcon, numberForks])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var starsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starIcon, numberStars])
        stack.axis = .horizontal
        return stack
    }()
    
    public lazy var repoTitle: UILabel = {
        let label = UILabel()
        label.text = "Test Title"
        label.font = UIFont(name: "Roboto-Medium", size: 22.0)
        return label
    }()
    
    public lazy var repoDescription: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet..."
        label.numberOfLines = 0
//        label.font = UIFont(name: Font.robotoThin.rawValue, size: 14.0)
        label.font = UIFont(name: "Roboto-Regular", size: 14.0)
        label.textColor = Theme.default.description
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
    
    private lazy var forkIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.fontAwesomeIcon(
            name: .codeBranch,
            style: .solid,
            textColor: Theme.default.purple,
            size: CGSize(width: 20, height: 20))
        return image
    }()
    
    private lazy var starIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.fontAwesomeIcon(
            name: .star,
            style: .solid,
            textColor: Theme.default.orange,
            size: CGSize(width: 12, height: 12))
        return image
    }()
    
    public lazy var numberStars: UILabel = {
        let label = UILabel()
        label.text = "456"
        label.textAlignment = .left
        label.font = UIFont(name: Font.robotoMedium.rawValue, size: 14.0)
        return label
    }()
    
    public lazy var numberForks: UILabel = {
        let label = UILabel()
        label.text = "359"
        label.textAlignment = .left
        label.font = UIFont(name: Font.robotoMedium.rawValue, size: 14.0)
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
            make.height.equalTo(140)
        }
        
        stackView.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        stackViewText.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(stackViewOwner.snp.left).offset(-10)
        }
        
        stackViewOwner.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(90)
        }
        
        stackNumbers.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(repoDescription.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        forksStack.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        starsStack.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(forksStack.snp.trailing)
            make.width.equalTo(forksStack.snp.width)
        }
        
        repoTitle.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        repoDescription.snp.makeConstraints { make in
            make.top.equalTo(repoTitle.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(60)
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
        
        starIcon.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalToSuperview()
        }
        
        forkIcon.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalToSuperview()
        }
        
        numberStars.snp.makeConstraints { make in
            make.left.equalTo(starIcon.snp.right).offset(10)
        }
        
        numberForks.snp.makeConstraints { make in
            make.left.equalTo(forkIcon.snp.right).offset(10)
        }
    }
    
    
}
