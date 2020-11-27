//
//  Owner.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct Owner: Mappable {
    var login: String?
    var avatar_url: String?
    
    init?(map: Map) {
        login = (try? map.value("login")) ?? ""
        avatar_url = (try? map.value("avatar_url")) ?? ""
    }
    
    mutating func mapping(map: Map) {
        login      <- map["login"]
        avatar_url <- map["avatar_url"]
    }
}
