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

class GithubWorker: Request {
    //Get Repo List
    func loadRepoList(page: Int = 0, completion: @escaping (_ response: ResponseGithubRepo<GithubData>) -> Void) {
        let offset = page * GithubEndpoints.limit
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
}
