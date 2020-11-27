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
    var viewController: ViewController?
    var repository: Repository?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(_ repository: Repository) {
        let viewController = self
        self.repository = repository
    }
}

extension RepositoriesCollectionViewCell {
    func enterOwnerRepository() {
        delegate?.routeToRepository()
    }
}
