//
//  ApiManager.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

class GithubEndpoints {
    public static var endpointRepo = ""
    static let basePath = "https://api.github.com/"
    static let search = "search/repositories?q=language:Swift&sort=stars&page=1"
    static let pulls = "repos/vsouza/awesome-ios/pulls"
    static let limit = 10

    static let repoOwner = ""
    static let repoName = ""
    
    public static var getReposEndpoint: String {
        get {
            return (basePath + search)
        }
    }
    
    public static var getPullRequestsEndpoint: String {
        get {
            return ("\(self.endpointRepo)" + "pull/")
        }
    }
}


