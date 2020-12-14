//
//  PullData.swift
//  GitRepo
//
//  Created by Thyago on 08/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct PullData: Mappable {
    var items: [PullRequests]?
    
    init?(map: Map) {
        items = [(try? map.value("items") ?? PullRequests(map: map))!]
    }
    
    mutating func mapping(map: Map) {
        items <- map["items"]
    }
}
