//
//  RealmUser.swift
//  VKApp
//
//  Created by Сергей Зесли on 01.03.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var domain: String? = ""
    @objc dynamic var firstName: String? = ""
    @objc dynamic var lastName: String? = ""
    @objc dynamic var nickname: String? = ""
    @objc dynamic var sex: Int = 1
    @objc dynamic var city: RealmCity? = nil
    
}
class RealmCity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String? = ""
    
}
