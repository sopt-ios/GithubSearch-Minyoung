//
//  ImageCache.swift
//  GithubSearch
//
//  Created by 구민영 on 08/02/2019.
//  Copyright © 2019 구민영. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    var cache: [String: UIImage] = [:]
    func addToCache(url: String, image: UIImage) {
        cache[url] = image
    }
    func image(forUrl urlString: String, completion: @escaping (UIImage?)->Void) -> UIImage? {
        if let image = cache[urlString] {
            return image
        }
        guard let url = URL(string: urlString) else {
            return #imageLiteral(resourceName: "default")
        }
        OperationQueue().addOperation {
            var image: UIImage? = nil
            let data = try? Data(contentsOf: url)
            if data != nil {
                image = UIImage(data: data!)
            }
            OperationQueue.main.addOperation {
                if image != nil {
                    self.addToCache(url: urlString, image: image!)
                }
                completion(image)
            }
        }
        return nil
    }
}
