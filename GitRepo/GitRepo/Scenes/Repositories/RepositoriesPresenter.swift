//
//  ReposPresenter.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol RepositoriesPresenterOutput: AnyObject {
    func displayStartLoading()
    func displayRepositories(viewModel: [GithubModels.RepositoryView.ViewModel])
    func displayError(error: String)
}

class RepositoriesPresenter: RepositoriesInteractorOutput {
    weak var output: RepositoriesPresenterOutput?
    var viewController: RepositoriesViewController?
    
    func didStartLoading() {
        output?.displayStartLoading()
    }
    
    func didGetData(_ repositories: [Repository]) {
        let viewModel = repositories.map({
            GithubModels.RepositoryView.ViewModel(
                name: $0.name,
                description: $0.description,
                stars: $0.stargazers_count,
                forks: $0.forks_count,
                avatar: $0.avatar,
                developer: $0.developer,
                pulls_url: $0.pulls_url)
        })
        
        output?.displayRepositories(viewModel: viewModel)
    }
    
    func didGetError(_ error: String) {
        output?.displayError(error: error)
    }
}

