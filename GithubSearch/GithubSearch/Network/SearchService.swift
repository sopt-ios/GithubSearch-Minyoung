//
//  SearchService.swift
//  GithubSearch
//
//  Created by 구민영 on 08/02/2019.
//  Copyright © 2019 구민영. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct SearchService : APIManager {
    let searchURL = url("/search/users")
    let userURL = url("/users")
}
