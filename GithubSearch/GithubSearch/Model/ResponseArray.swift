//
//  ResponseArray.swift
//  GithubSearch
//
//  Created by 구민영 on 08/02/2019.
//  Copyright © 2019 구민영. All rights reserved.
//

import Foundation
import ObjectMapper

struct ResponseArray<T: Mappable>: Mappable {
    
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [T]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        total_count <- map["total_count"]
        incomplete_results <- map["incomplete_results"]
        items <- map["items"]
    }
}
