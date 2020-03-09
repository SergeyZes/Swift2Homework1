//
//  RealGroup.swift
//  VKApp
//
//  Created by Сергей Зесли on 01.03.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation
import RealmSwift

class RealmGroup: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String? = ""
    @objc dynamic var descriptionField: String? = ""
    @objc dynamic var screenName: String? = ""
    @objc dynamic var photo50: String? = ""
    @objc dynamic var photo100: String? = ""
    @objc dynamic var photo200: String? = ""
    
}
