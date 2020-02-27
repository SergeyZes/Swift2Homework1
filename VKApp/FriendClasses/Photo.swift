//
//  Photo.swift
//  VKApp
//
//  Created by Сергей Зесли on 27.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class Photo {
    let id: Int
    let text: String
    var img: UIImage
    
    init(id: Int, text: String, img: UIImage) {
        self.id = id
        self.text = text
        self.img = img
    }
}
