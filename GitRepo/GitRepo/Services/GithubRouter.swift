//
//  ReposRouter.swift
//  GitRepo
//
//  Created by Thyago on 30/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol GithubRouterRoutingLogic {
    func routeToPullRequests()
}

protocol GithubRouterDataPass {
    var dataStore: ReposInteractorDataStore? { get }
    var repository: Repository? { get set }
    var owner: Owner? { get set }
}

class GithubRouter: NSObject, GithubRouterRoutingLogic, GithubRouterDataPass {
    var repository: Repository?
    var owner: Owner?
    var viewController: ReposViewController?
    var interactor: ReposInteractor?
    var dataStore: ReposInteractorDataStore?
    
    func routeToPullRequests() {
//        let destinyViewController =
//        let destinyDataStore =
    }
    
    //MARK: - Passing Data and Routing to Cell
    
    func passDataToCell(destination: inout ReposInteractorDataStore) {
        guard let repositoryRow = viewController?.collectionView.collectionView.indexPathsForVisibleItems.first?.row else { return }
        destination.repository = dataStore?.repository ?? []
        destination.owner = dataStore?.owner ?? []
    }
    
    func routeToCollectionCell() {
        let destinyViewController = RepositoriesCollectionViewCell()
        var destinyDataStore = destinyViewController.router!.dataStore!
        passDataToCell(destination: &destinyDataStore)
    }
}
