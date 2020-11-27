//
//  ReposInteractor.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol ReposInteractorBusinessLogic {
    func getData()
}

class ReposInteractor: ReposInteractorBusinessLogic {
    var repository: Repository?
    var data: GithubData?
    var worker: GithubWorker = GithubWorker()
    var viewController: ReposViewController?
    var presenter: ReposPresenter?
}

//MARK: - Display Methods

extension ReposInteractor {
    func getData() {
        self.worker.loadRepoList { (response) in
            switch response {
            case .success(let model):
                let repos = model.data
                let items = repos.items
            case .serverError(let error):
                let errorData = "\(error.statusCode), -, \(error.msgError)"
                print("Server error: \(errorData) \n")
                break
            case .timeOut(let description):
                print("Server error noConnection: \(description) \n")
            case .noConnection(let description):
                print("Server error timeOut: \(description) \n")
            }
        }
    }
}

extension ReposInteractor: RepositoriesCollectionViewInteractorLogic {
    func itemsCount() -> Int {
        let items = data?.items
        return items?.count ?? 0
    }
}
