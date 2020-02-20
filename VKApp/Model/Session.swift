//
//  Session.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation

class Session {
    static let instance = Session()
    
    private init (){
        
    }
    
    var token: String = ""
    var userId: Int = 0
}
