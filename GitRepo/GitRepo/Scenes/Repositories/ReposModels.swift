//
//  ReposModels.swift
//  GitRepo
//
//  Created by Thyago on 27/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

struct ReposModels {
    struct RepositoryView {
        struct Request {
            var owner: [Owner]?
        }
        
        struct Response {
            var name: String?
            var description: String?
            var stars: Int?
            var forks: Int?
            var owner: [Owner]?
        }
        
        struct ViewModel {
            let name: String?
            let description: String?
            let stars: Int?
            let forks: Int?
        }
    }
}
