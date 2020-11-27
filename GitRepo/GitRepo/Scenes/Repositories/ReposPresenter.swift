//
//  ReposPresenter.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol ReposPresenterPresentationLogic: class {
    
}

class ReposPresenter: ReposPresenterPresentationLogic {
    weak var viewController: ReposViewController?
    var reposCollectionView: RepositoriesCollectionView?
}
