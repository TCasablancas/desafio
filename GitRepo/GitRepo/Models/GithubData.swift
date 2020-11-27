//
//  GithubData.swift
//  GitRepo
//
//  Created by Thyago on 26/11/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import ObjectMapper

struct GithubData: Mappable {
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [Repository]?
    
    init?(map: Map) {
        total_count = (try? map.value("total_count")) ?? 0
        incomplete_results =  (try? map.value("incomplete_results")) ?? false
        items = [(try? map.value("items")) ?? Repository(map: map)!]
    }
    
    mutating func mapping(map: Map) {
        total_count        <- map["total_count"]
        incomplete_results <- map["incomplete_results"]
        items              <- map["items"]
    }
}
