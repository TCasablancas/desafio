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
    weak var viewController: ReposViewControllerDisplayLogic?
    var reposCollectionView: RepositoriesCollectionView?

    func presentRepository(response: ReposModels.RepositoryView.Response) {
        let name = response.name
        let description = response.description
        let stars = response.stars
        let forks = response.forks
        
        let model = ReposModels.RepositoryView.ViewModel(name: name, description: description, stars: stars, forks: forks)
        
        viewController?.displayRepositories(viewModel: model)
    }
}

