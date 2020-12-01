//
//  Repository.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct Repository: Mappable {
    var name: String?
    var url: String?
    var description: String?
    var stargazers_count: Int?
    var forks_count: Int?
    var owner: [Owner]?
    
    init?(map: Map) {
        name = (try? map.value("name")) ?? ""
        url = (try? map.value("url")) ?? ""
        description = (try? map.value("description")) ?? ""
        stargazers_count = (try? map.value("stargazers_count")) ?? 0
        forks_count = (try? map.value("forks_count")) ?? 0
        owner = [(try? map.value("owner")) ?? Owner(map: map)!]
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
        description <- map["description"]
        stargazers_count <- map["stargazers_count"]
        forks_count <- map["forks_count"]
        owner <- map["owner"]
    }
}
