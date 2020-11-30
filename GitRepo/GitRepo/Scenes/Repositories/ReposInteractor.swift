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

protocol ReposInteractorDataStore {
    var repository: [Repository] { get set }
    var datarepository: Repository? { get set }
}

class ReposInteractor: ReposInteractorBusinessLogic, ReposInteractorDataStore {
    var repository: [Repository] = []
    var data: GithubData?
    var router: GithubRouter?
    var worker: GithubWorker = GithubWorker()
    var viewController: ReposViewController?
    var collectionView: RepositoriesCollectionView?
    var presenter: ReposPresenter?
    var datarepository: Repository?
    var rowAtIndex = 10
    
    public var title = ""
}

//MARK: - Display Methods

extension ReposInteractor {
    func getData() {
        self.worker.loadRepoList() { (response) in
            switch response {
            case .success(let model):
                let repositories = model.items
                self.repository = repositories
                
                self.displayRepoCells()
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

extension ReposInteractor {
    func displayError() {
        
    }
    
    func displayRepoCells() {
        let indexPath = currentIndex
        let repo = self.items(at: indexPath)
        
        self.presenter?.presentRepository(response: ReposModels.RepositoryView.Response(
            name: repo?.name, description: repo?.description, stars: repo?.stargazers_count, forks: repo?.forks_count)
        )
    }
}

extension ReposInteractor: RepositoriesCollectionViewInteractorLogic {
    var currentIndex: Int {
        return rowAtIndex
    }
    
    func itemsCount() -> Int {
        let items = repository.count
        return items
    }
    
    func items(at index: Int) -> Repository? {
        if repository.count > index {
            return repository[index]
        }
        return nil
    }
}
