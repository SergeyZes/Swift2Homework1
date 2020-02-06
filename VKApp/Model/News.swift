//
//  News.swift
//  VKApp
//
//  Created by Сергей Зесли on 03.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class News {
    let id: Int
    let user: User
    let newsDate: Date
    let news: String
    let image: UIImage
    let views: Int
    
    init(id: Int, user: User, newsDate: Date, news: String, image: UIImage, views: Int) {
        self.id = id
        self.user = user
        self.newsDate = newsDate
        self.news = news
        self.image = image
        self.views = views
    }
    
}
