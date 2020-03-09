//
//  RealmPhoto.swift
//  VKApp
//
//  Created by Сергей Зесли on 01.03.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPhoto: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var picture = Data()
}
