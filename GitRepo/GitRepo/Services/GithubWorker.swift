//
//  Worker.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol GithubWorkerDelegate {
    func loadRepoList(page: Int, completion: @escaping (_ response: ResponseGithubRepo<GithubData>) -> Void)
    func loadPullRequestList(completion: @escaping (_ response: ResponseGithubRepo<PullRequests>) -> Void)
    func getResultValue() -> [[String:Any]]
}

class GithubWorker: Request, GithubWorkerDelegate {
    
    public var result: [[String:Any]]?
    
    //Get Repo List
    func loadRepoList(page: Int = 0, completion: @escaping (_ response: ResponseGithubRepo<GithubData>) -> Void) {
        let offset = page * 10
        let url = GithubEndpoints.getReposEndpoint
        
        Alamofire.request(url).responseJSON { (data: DataResponse<Any>) in
            let statusCode = data.response?.statusCode

            switch data.result {
            case .success(let value):
                guard let resultValue = value as? [String:Any] else { return }
                
                if statusCode == 200 {
                    guard let model = Mapper<GithubData>().map(JSON: resultValue) else { return }
                    completion(.success(model: model))
                }
            case .failure(let error):
                let errorCode = error._code
                if errorCode == -1009 {
                    let erro = ServerError(msgError: error.localizedDescription, statusCode: errorCode)
                    completion(.noConnection(description: erro))
                } else if errorCode == -1001 {
                    let erro = ServerError(msgError: error.localizedDescription, statusCode: errorCode)
                    completion(.timeOut(description: erro))
                }
            }
        }
    }
    
    // Get Pull Request List
    func loadPullRequestList(completion: @escaping (_ response: ResponseGithubRepo<PullRequests>) -> Void) {
        let url = GithubEndpoints.getPullRequestsEndpoint
        
        Alamofire.request(url).responseJSON { (data: DataResponse<Any>) -> Void in
            let statusCode = data.response?.statusCode
            switch data.result {
            case .success(let value):
                guard let resultValue = value as? [[String:Any]] else { return }
                
                self.result = resultValue
                
                if statusCode == 200 {
                    let model = Mapper<PullRequests>().map(JSONObject: resultValue)
                    completion(.success(model: model!))
                }
            case .failure(let error):
                let errorCode = error._code
                if errorCode == -1009 {
                    let erro = ServerError(msgError: error.localizedDescription, statusCode: errorCode)
                    completion(.noConnection(description: erro))
                } else if errorCode == -1001 {
                    let erro = ServerError(msgError: error.localizedDescription, statusCode: errorCode)
                    completion(.timeOut(description: erro))
                }
            }
        }
    }
    
    func getResultValue() -> [[String:Any]] {
        return self.result ?? [[:]]
    }
}
