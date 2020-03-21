//
//  NewsUnit.swift
//  VKApp
//
//  Created by Сергей Зесли on 21.03.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class NewsUnit {
    let date: Int
    let likes: Int
    let text: String
    let path: String
    var img: UIImage
    
    init(date: Int, likes: Int, text: String, path: String, img: UIImage) {
        self.date = date
        self.likes = likes
        self.text = text
        self.path = path
        self.img = img
    }
}
