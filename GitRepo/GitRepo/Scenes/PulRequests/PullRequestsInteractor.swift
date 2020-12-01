//
//  PullRequestsInteractor.swift
//  GitRepo
//
//  Created by Thyago on 01/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol PullRequestsInteractorBusinessLogic {
    
}

protocol PullRequestsInteractorDataStore {
    var dataStore: PullRequestsInteractorDataStore? { get }
}

class PullRequestsInteractor: PullRequestsInteractorBusinessLogic, PullRequestsInteractorDataStore {
    var dataStore: PullRequestsInteractorDataStore?
    var worker: GithubWorker = GithubWorker()
}
