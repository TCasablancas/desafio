//
//  PullRequestsInteractor.swift
//  GitRepo
//
//  Created by Thyago on 01/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol PullRequestsInteractorBusinessLogic {
    func getPullRequests()
}

protocol PullRequestsInteractorOutput {
    func didStartLoading()
    func didGetData(_ pullRequests: [PullRequests])
    func didGetError(_ error: String)
}

class PullRequestsInteractor: PullRequestsInteractorBusinessLogic {
    let output: PullRequestsInteractorOutput
    let worker: GithubWorkerDelegate
    
    init(output: PullRequestsInteractorOutput, worker: GithubWorkerDelegate) {
        self.output = output
        self.worker = worker
    }
    
    func getPullRequests() {
        worker.loadPullRequestList() { [output] (response) in
            switch response {
            case .success(let model):
                let creation = model.created_at
                let title = model.title
                let body = model.body
                
                print("DADOS DO REPO: ", creation, title, body)
                
            case .serverError(let error):
                let errorData = "\(error.statusCode), -, \(error.msgError)"
                output.didGetError(errorData)
                print("Server error: \(errorData) \n")
                break
            case .timeOut(let description):
                print("Server error noConnection: \(description) \n")
                output.didGetError("Timeout")
                
            case .noConnection(let description):
                output.didGetError("Offline")
                print("Server error timeOut: \(description) \n")
            }
        }
    }
}
