//
//  PullRequests.swift
//  GitRepo
//
//  Created by Thyago on 01/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct PullRequests: Mappable {
    var title: String?
    var body: String?
    var created_at: String?
    var user: [User]
    
    init?(map: Map) {
        title = (try? map.value("title")) ?? ""
        body = (try? map.value("body")) ?? ""
        created_at = (try? map.value("created_at")) ?? ""
        user = [(try? map.value("user")) ?? User(map: map)!]
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        body <- map["body"]
        created_at <- map["created_at"]
        user <- map["user"]
    }
}
