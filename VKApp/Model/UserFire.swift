//
//  UserFire.swift
//  VKApp
//
//  Created by Сергей Зесли on 17.03.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserFire {
    let id: Int
    let ref: DatabaseReference?
    
    init(id: Int) {
        self.ref = nil
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any], let id = value["id"] as? Int else {
            return nil
        }
        self.ref = snapshot.ref
        self.id = id
    }
    
    func toAnyObject() -> [String: Any]{
        return [
            "id": id
        ]
    }
}
