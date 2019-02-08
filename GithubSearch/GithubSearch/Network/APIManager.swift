//
//  APIManager.swift
//  GithubSearch
//
//  Created by 구민영 on 08/02/2019.
//  Copyright © 2019 구민영. All rights reserved.
//

import Foundation

protocol APIManager {}

extension APIManager {
    static func url(_ path: String) -> String {
        return "http://52.78.243.92:8080"+path
    }
}
