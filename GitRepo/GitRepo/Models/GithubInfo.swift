//
//  GithubInfo.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct GithubInfo: Mappable {
    var code: Int
    var status: String
    var data: GithubData
    
    init?(map: Map) {
        code   = (try? map.value("code")) ?? 0
        status = (try? map.value("status")) ?? ""
        data   = (try? map.value("data")) ?? GithubData(map: map)!
    }
    
    mutating func mapping(map: Map) {
        code   <- map["code"]
        status <- map["status"]
        data   <- map["data"]
    }
}
