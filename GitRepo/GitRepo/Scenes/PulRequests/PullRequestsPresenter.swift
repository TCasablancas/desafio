//
//  PullRequestsPresenter.swift
//  GitRepo
//
//  Created by Thyago on 01/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol PullRequestsPresenterOutput: AnyObject {
    func displayStartLoading()
    func displayPullRequestList(viewModel: [GithubModels.PullRequestView.ViewModel])
    func displayError(error: String)
}

class PullRequestsPresenter: PullRequestsInteractorOutput {
    weak var output: PullRequestsPresenterOutput?
    var viewController: PullRequestsViewController?
    
    func didStartLoading() {
        output?.displayStartLoading()
    }
    
    func didGetData(_ pullRequests: [PullRequests]) {
        let viewModel = pullRequests.map({
            GithubModels.PullRequestView.ViewModel(
                title: $0.title,
                body: $0.body,
                created_at: $0.created_at,
                avatar: $0.avatar,
                developer: $0.developer)
        })
        
        output?.displayPullRequestList(viewModel: viewModel)
    }
    
    func didGetError(_ error: String) {
        output?.displayError(error: error)
    }
    
}
