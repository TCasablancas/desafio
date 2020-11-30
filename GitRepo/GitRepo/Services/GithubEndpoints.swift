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
    static let search = "search/repositories?q=language:Swift&sort=stars&page=1"
    static let limit = 10

    public static var getReposEndpoint: String {
        get {
            return (basePath + search)
        }
    }
}


