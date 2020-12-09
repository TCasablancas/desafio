//
//  PullRequestsCollectionViewCell.swift
//  GitRepo
//
//  Created by Thyago on 08/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import FontAwesome_swift

protocol PullRequestsCollectionViewCellDelegate: AnyObject {
    func routeToRepository(_ repository: GithubModels.PullRequestView.ViewModel)
}

class PullRequestsCollectionViewCell: UICollectionViewCell {
    //MARK: - UI
    private lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textStack, devStack])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconPull, pullTitle])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStack, pullDescription])
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var devStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStack, pullDescription])
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var iconPull: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var pullTitle: TitleView = {
        let label = TitleView()
        return label
    }()
    
    private lazy var pullDescription: DescriptionView = {
        let label = DescriptionView()
        return label
    }()
    
    private lazy var owner: OwnerView = {
        let owner = OwnerView()
        return owner
    }()
    
    public weak var delegate: PullRequestsCollectionViewCellDelegate?
    private var pullRequest: GithubModels.PullRequestView.ViewModel?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureWith(with pullRequest: GithubModels.PullRequestView.ViewModel) {
        self.pullRequest = pullRequest
    }
}

extension PullRequestsCollectionViewCell: ViewCode {
    func viewHierarchy() {
        self.addSubview(container)
    
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    
}
