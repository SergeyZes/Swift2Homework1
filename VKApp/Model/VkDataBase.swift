//
//  VkDataBase.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class VkDataBase{
    private static var uniqueInstance: VkDataBase?
    private init(){}
    
    var friends: [User] = [User(id: 1, name: "Арнольд Шварценеггер", image: UIImage(named: "arnold")!),
                           User(id: 2, name: "Владимир Жириновский", image: UIImage(named: "zhirinovsky")!),
                           User(id: 3, name: "Сергей Лавров", image: UIImage(named: "lavrov")!)
    ]
    var allGroups: [Group] = [Group(id: 1, name: "Программисты", image: UIImage(named: "programmers")!),
                           Group(id: 2, name: "Студенты", image: UIImage(named: "students")!),
                           Group(id: 3, name: "Кошки", image: UIImage(named: "cats")!),
                           Group(id: 4, name: "Собаки", image: UIImage(named: "dogs")!)
    ]
    var myGroups: [Group] = [Group(id: 1, name: "Программисты", image: UIImage(named: "programmers")!),
                           Group(id: 2, name: "Студенты", image: UIImage(named: "students")!)
    ]
    
    var allNews = [News]()

    
    
    static func shared() -> VkDataBase {
        if uniqueInstance == nil {
            uniqueInstance = VkDataBase()
            
            uniqueInstance?.allNews.append(News(id: 1, user: uniqueInstance!.friends[2], newsDate: Date(),
                                                news: "Президент США Дональд Трамп ввел иммиграционные ограничения в отношении граждан Нигерии, Мьянмы, Эритреи, Киргизии, Судана и Танзании.",
                                                image: UIImage(named: "trump")!, views: 10))
            uniqueInstance?.allNews.append(News(id: 2, user: uniqueInstance!.friends[1], newsDate: Date(),
                                                news: "Си Цзиньпин назвал ситуацию с эпидемией коронавируса в Китае сложной.",
                                                image: UIImage(named: "xi")!, views: 7))
        }
        
        return uniqueInstance!
    }
}
