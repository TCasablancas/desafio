//
//  ReposModels.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

struct GithubModels {
    struct RepositoryView {
        struct Request {
        }
        
        struct Response {
            var name: String?
            var description: String?
            var stars: Int?
            var forks: Int?
            var avatar: String?
            var developer: String?
            var pulls_url: String?
        }
        
        struct ViewModel {
            let name: String?
            let description: String?
            let stars: Int?
            let forks: Int?
            let avatar: String?
            let developer: String?
            let pulls_url: String?
        }
    }
}