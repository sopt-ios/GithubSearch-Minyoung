//
//  NetworkResult.swift
//  GithubSearch
//
//  Created by 구민영 on 08/02/2019.
//  Copyright © 2019 구민영. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case error(Error)
}
