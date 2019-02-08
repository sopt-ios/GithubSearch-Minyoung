//
//  ImageView+RoundCorner.swift
//  GithubSearch
//
//  Created by 구민영 on 08/02/2019.
//  Copyright © 2019 구민영. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func roundCorner() {
        self.layer.cornerRadius = self.bounds.size.width * 0.5
        self.clipsToBounds = true
    }
}
