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
    static let shared = SearchService()
    
    let searchURL = url("/search/users")
    let userURL = url("/users")
    
    func getResultList(page: Int? = 1,
                       limit: Int = 20,
                       input : String,
                       completion : @escaping ([Items]) -> Void) {

        let header: HTTPHeaders = [
            "Authorization": ""
        ]
        
        let queryURL = searchURL + "?q=\(input)&page=\(page ?? 1)&per_page=\(limit)"
        
        Alamofire.request(queryURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject { (res: DataResponse<ResponseArray<Items>>) in
            switch res.result {
                
            case .success:
                guard let data = res.result.value else {return}
                guard let itemList = data.items else {return}
                completion(itemList)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getNumOfRepos(name : String,
                       completion : @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": ""
        ]
        
        let queryURL = userURL + "/" + name
        
        Alamofire.request(queryURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject { (res: DataResponse<ResponseBody>) in
            switch res.result {
                
            case .success:
                guard let data = res.result.value else {return}
                guard let reposNum = data.public_repos else {return}
                completion(reposNum)
                
            case .failure(let err):
                print(err)
            }
        }
    }
}
