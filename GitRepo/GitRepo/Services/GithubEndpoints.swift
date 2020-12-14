//
//  ApiManager.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

class GithubEndpoints {
    static let basePath = "https://api.github.com/"
    static let search = "search/repositories?q=language:Swift"
    static var repo_name = ""
    
    public static var getReposEndpoint: String {
        get {
            return (basePath + search)
        }
    }
    
    public static var getPullRequestsEndpoint: String {
        get {
            return (basePath + "repos/" + repo_name + "/pulls")
        }
    }
}


