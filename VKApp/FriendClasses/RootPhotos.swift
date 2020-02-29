//
//  RootPhotos.swift
//  VKApp
//
//  Created by Сергей Зесли on 27.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation

struct RootPhotos : Codable {

        let response : ResponsePhotos?

        enum CodingKeys: String, CodingKey {
                case response = "response"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                response = try ResponsePhotos(from: decoder)
//        }

}

struct ResponsePhotos : Codable {

        let count : Int?
        let items : [ItemPhotos]?

        enum CodingKeys: String, CodingKey {
                case count = "count"
                case items = "items"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                count = try values.decodeIfPresent(Int.self, forKey: .count)
//                items = try values.decodeIfPresent([ItemPhotos].self, forKey: .items)
//        }

}

struct ItemPhotos : Codable {

        let albumId : Int?
        let date : Int?
        let id : Int?
        let likes : LikePhotos?
        let ownerId : Int?
        let postId : Int?
        let reposts : RepostPhotos?
        let sizes : [SizePhotos]?
        let text : String?

        enum CodingKeys: String, CodingKey {
                case albumId = "album_id"
                case date = "date"
                case id = "id"
                case likes = "likes"
                case ownerId = "owner_id"
                case postId = "post_id"
                case reposts = "reposts"
                case sizes = "sizes"
                case text = "text"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                albumId = try values.decodeIfPresent(Int.self, forKey: .albumId)
//                date = try values.decodeIfPresent(Int.self, forKey: .date)
//                id = try values.decodeIfPresent(Int.self, forKey: .id)
//                likes = try LikePhotos(from: decoder)
//                ownerId = try values.decodeIfPresent(Int.self, forKey: .ownerId)
//                postId = try values.decodeIfPresent(Int.self, forKey: .postId)
//                reposts = try RepostPhotos(from: decoder)
//                sizes = try values.decodeIfPresent([SizePhotos].self, forKey: .sizes)
//                text = try values.decodeIfPresent(String.self, forKey: .text)
//        }

}

struct SizePhotos : Codable {

        let height : Int?
        let type : String?
        let url : String?
        let width : Int?

        enum CodingKeys: String, CodingKey {
                case height = "height"
                case type = "type"
                case url = "url"
                case width = "width"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                height = try values.decodeIfPresent(Int.self, forKey: .height)
//                type = try values.decodeIfPresent(String.self, forKey: .type)
//                url = try values.decodeIfPresent(String.self, forKey: .url)
//                width = try values.decodeIfPresent(Int.self, forKey: .width)
//        }

}

struct RepostPhotos : Codable {

        let count : Int?

        enum CodingKeys: String, CodingKey {
                case count = "count"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                count = try values.decodeIfPresent(Int.self, forKey: .count)
//        }

}

struct LikePhotos : Codable {

        let count : Int?
        let userLikes : Int?

        enum CodingKeys: String, CodingKey {
                case count = "count"
                case userLikes = "user_likes"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                count = try values.decodeIfPresent(Int.self, forKey: .count)
//                userLikes = try values.decodeIfPresent(Int.self, forKey: .userLikes)
//        }

}



