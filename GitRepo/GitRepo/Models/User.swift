//
//  User.swift
//  GitRepo
//
//  Created by Thyago on 01/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var avatar_url: String?
    var login: String?
    
    init?(map: Map) {
        avatar_url = (try? map.value("avatar_url")) ?? ""
        login = (try? map.value("login")) ?? ""
    }
    
    mutating func mapping(map: Map) {
        avatar_url <- map["avatar_url"]
        login <- map["login"]
    }
}
