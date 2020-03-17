//
//  GroupFire.swift
//  VKApp
//
//  Created by Сергей Зесли on 17.03.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation
import FirebaseDatabase

class GroupFire {
    let userId: Int
    let name: String
    let ref: DatabaseReference?
    
    init(userId: Int, name: String) {
        self.ref = nil
        self.userId = userId
        self.name = name
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any], let userId = value["userId"] as? Int, let name = value["name"] as? String else {
            return nil
        }
        self.ref = snapshot.ref
        self.userId = userId
        self.name = name
    }
    
    func toAnyObject() -> [String: Any]{
        return [
            "userId": userId,
            "name": name
        ]
    }

}
