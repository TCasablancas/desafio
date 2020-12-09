//
//  Repository.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct Repository: Mappable, Equatable {
    var name: String?
    var url: String?
    var description: String?
    var stargazers_count: Int?
    var forks_count: Int?
    var pulls_url: String?
    var owner: Owner?
    
    //MARK: - Retrieve Owner Data
    var avatar: String? { owner?.avatar_url }
    var developer: String? { owner?.login }
    
    //MARK: - Initializer for Tests
    init(name: String? = nil, url: String? = nil, description: String? = nil, stargazers_count: Int? = nil, forks_count: Int? = nil, pulls_url: String? = nil, owner: Owner? = nil) {
        self.name = name
        self.url = url
        self.description = description
        self.stargazers_count = stargazers_count
        self.forks_count = forks_count
        self.pulls_url = pulls_url
        self.owner = owner
    }
    
    init?(map: Map) {
        name = (try? map.value("name")) ?? ""
        url = (try? map.value("url")) ?? ""
        description = (try? map.value("description")) ?? ""
        stargazers_count = (try? map.value("stargazers_count")) ?? 0
        forks_count = (try? map.value("forks_count")) ?? 0
        pulls_url = (try? map.value("pulls_url")) ?? ""
        owner = (try? map.value("owner"))
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
        description <- map["description"]
        stargazers_count <- map["stargazers_count"]
        forks_count <- map["forks_count"]
        pulls_url <- map["pulls_url"]
        owner <- map["owner"]
    }

    //MARK: - Test Data Comparative
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        lhs.url == rhs.url
    }
}
