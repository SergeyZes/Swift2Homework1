//
//  RootGroups.swift
//  VKApp
//
//  Created by Сергей Зесли on 27.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation

struct RootGroups : Codable {

        let response : ResponseGroups?

        enum CodingKeys: String, CodingKey {
                case response = "response"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                response = try ResponseGroups(from: decoder)
//        }

}

struct ResponseGroups : Codable {

        let count : Int?
        let items : [ItemGroups]?

        enum CodingKeys: String, CodingKey {
                case count = "count"
                case items = "items"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                count = try values.decodeIfPresent(Int.self, forKey: .count)
//                items = try values.decodeIfPresent([ItemGroups].self, forKey: .items)
//        }

}

struct ItemGroups : Codable {

        let descriptionField : String?
        let id : Int?
        let isAdmin : Int?
        let isAdvertiser : Int?
        let isClosed : Int?
        let isMember : Int?
        let name : String?
        let photo100 : String?
        let photo200 : String?
        let photo50 : String?
        let screenName : String?
        let type : String?

        enum CodingKeys: String, CodingKey {
                case descriptionField = "description"
                case id = "id"
                case isAdmin = "is_admin"
                case isAdvertiser = "is_advertiser"
                case isClosed = "is_closed"
                case isMember = "is_member"
                case name = "name"
                case photo100 = "photo_100"
                case photo200 = "photo_200"
                case photo50 = "photo_50"
                case screenName = "screen_name"
                case type = "type"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
//                id = try values.decodeIfPresent(Int.self, forKey: .id)
//                isAdmin = try values.decodeIfPresent(Int.self, forKey: .isAdmin)
//                isAdvertiser = try values.decodeIfPresent(Int.self, forKey: .isAdvertiser)
//                isClosed = try values.decodeIfPresent(Int.self, forKey: .isClosed)
//                isMember = try values.decodeIfPresent(Int.self, forKey: .isMember)
//                name = try values.decodeIfPresent(String.self, forKey: .name)
//                photo100 = try values.decodeIfPresent(String.self, forKey: .photo100)
//                photo200 = try values.decodeIfPresent(String.self, forKey: .photo200)
//                photo50 = try values.decodeIfPresent(String.self, forKey: .photo50)
//                screenName = try values.decodeIfPresent(String.self, forKey: .screenName)
//                type = try values.decodeIfPresent(String.self, forKey: .type)
//        }

}


