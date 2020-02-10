//
//  User.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class User {
    let id: Int
    let name: String
    let image: UIImage
    let images: [UIImage]
    init(id: Int, name: String, image: UIImage, images: [UIImage]) {
        self.id = id
        self.name = name
        self.image = image
        self.images = images
    }
}
