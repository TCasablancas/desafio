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
    func loadRepoList(page: Int = 0, completion: @escaping (_ response: ResponseData) -> Void) {
        let offset = page * GithubEndpoints.limit
        let url = GithubEndpoints.getReposEndpoint
        
        Alamofire.request(url).responseJSON { (data) in
            let statusCode = data.response?.statusCode
            switch data.result {
            case .success(let value):
                let resultValue = value as? [String:Any]
                if statusCode == 200 {
                    let model = Mapper<GithubInfo>().map(JSONObject: resultValue)
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
}
