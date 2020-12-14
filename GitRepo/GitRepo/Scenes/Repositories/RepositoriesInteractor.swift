//
//  ReposInteractor.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol RepositoriesInteractorBusinessLogic {
    func getData()
}

protocol RepositoriesInteractorOutput {
    func didStartLoading()
    func didGetData(_ repositories: [Repository])
    func didGetError(_ error: String)
}

class ReposInteractor: RepositoriesInteractorBusinessLogic {
    
    let output: RepositoriesInteractorOutput
    let worker: GithubWorkerDelegate

    init(output: RepositoriesInteractorOutput, worker: GithubWorkerDelegate) {
        self.output = output
        self.worker = worker
    }
    
    // FIXME: Pass page number
    func getData() {
        output.didStartLoading()
        
        self.worker
            .loadRepoList(page: 2) { [output] (response) in
            switch response {
            case .success(let model):
                
                output.didGetData(model.items)
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
