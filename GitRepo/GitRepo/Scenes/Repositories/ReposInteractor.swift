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
    var owner: [Owner] { get set }
}

class ReposInteractor: ReposInteractorBusinessLogic, ReposInteractorDataStore {
    var repository: [Repository] = []
    var owner: [Owner] = []
    var data: GithubData?
    var router: GithubRouter?
    var worker: GithubWorker = GithubWorker()
    var viewController: ReposViewController?
    var collectionView: RepositoriesCollectionView?
    var collectionViewCell: RepositoriesCollectionViewCell?
    var presenter: ReposPresenter?
    var datarepository: Repository?
    var rowAtIndex = 10
    
    public var repoCount: Int?
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
                
                self.repoCount = repositories.count
                
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
    
    func search() {
        self.worker.loadPullRequestList() { (response) in
            switch response {
            case .success(let model):
                let name = model.title
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
    
    func reloadCell() {
//        self.viewController?.collectionView.reload()
        self.viewController?.activityIndicator.stopAnimating()
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
//        return self.repoCount ?? 1
        return 10
    }
    
    func items(at index: Int) -> Repository? {
        if repository.count > index {
            return repository[index]
        }
        return nil
    }
}
