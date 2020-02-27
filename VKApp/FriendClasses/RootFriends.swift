//
//  RootFriends.swift
//  VKApp
//
//  Created by Сергей Зесли on 27.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation

struct RootFriends : Codable {

        let response : ResponseFriends?

        enum CodingKeys: String, CodingKey {
                case response = "response"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                response = ResponseFriends(from: decoder)
//        }

}

struct ResponseFriends : Codable {

        let count : Int?
        let items : [UserFriends]?

        enum CodingKeys: String, CodingKey {
                case count = "count"
                case items = "items"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                count = try values.decodeIfPresent(Int.self, forKey: .count)
//                items = try values.decodeIfPresent([UserFriens].self, forKey: .items)
//        }

}

struct UserFriends : Codable {

        let canAccessClosed : Bool?
        let city : CityFriends?
        let country : CountryFriends?
        let domain : String?
        let firstName : String?
        let id : Int?
        let isClosed : Bool?
        let lastName : String?
        let lists : [Int]?
        let nickname : String?
        let online : Int?
        let sex : Int?
        let trackCode : String?

        enum CodingKeys: String, CodingKey {
                case canAccessClosed = "can_access_closed"
                case city = "city"
                case country = "country"
                case domain = "domain"
                case firstName = "first_name"
                case id = "id"
                case isClosed = "is_closed"
                case lastName = "last_name"
                case lists = "lists"
                case nickname = "nickname"
                case online = "online"
                case sex = "sex"
                case trackCode = "track_code"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                canAccessClosed = try values.decodeIfPresent(Bool.self, forKey: .canAccessClosed)
//                city = CityFriends(from: decoder)
//                country = CountryFriends(from: decoder)
//                domain = try values.decodeIfPresent(String.self, forKey: .domain)
//                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
//                id = try values.decodeIfPresent(Int.self, forKey: .id)
//                isClosed = try values.decodeIfPresent(Bool.self, forKey: .isClosed)
//                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
//                lists = try values.decodeIfPresent([Int].self, forKey: .lists)
//                nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
//                online = try values.decodeIfPresent(Int.self, forKey: .online)
//                sex = try values.decodeIfPresent(Int.self, forKey: .sex)
//                trackCode = try values.decodeIfPresent(String.self, forKey: .trackCode)
//        }

}

struct CountryFriends : Codable {

        let id : Int?
        let title : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case title = "title"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                id = try values.decodeIfPresent(Int.self, forKey: .id)
//                title = try values.decodeIfPresent(String.self, forKey: .title)
//        }

}

struct CityFriends : Codable {

        let id : Int?
        let title : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case title = "title"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                id = try values.decodeIfPresent(Int.self, forKey: .id)
//                title = try values.decodeIfPresent(String.self, forKey: .title)
//        }

}


