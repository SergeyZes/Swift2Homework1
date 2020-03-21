//
//  RootNews.swift
//  VKApp
//
//  Created by Сергей Зесли on 19.03.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import Foundation

struct RootNews : Codable {

        let response : ResponseNews?

        enum CodingKeys: String, CodingKey {
                case response = "response"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                response = Response(from: decoder)
//        }

}

struct ResponseNews : Codable {

        let groups : [GroupNews]?
        let items : [ItemNews]?
        let profiles : [ProfileNews]?

        enum CodingKeys: String, CodingKey {
                case groups = "groups"
                case items = "items"
                case profiles = "profiles"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                groups = try values.decodeIfPresent([Group].self, forKey: .groups)
//                items = try values.decodeIfPresent([Item].self, forKey: .items)
//                profiles = try values.decodeIfPresent([Profile].self, forKey: .profiles)
//        }

}

struct ProfileNews : Codable {

        let firstName : String?
        let id : Int?
        let lastName : String?
        let online : Int?
        let onlineInfo : OnlineInfoNews?
        let photo100 : String?
        let photo50 : String?
        let screenName : String?
        let sex : Int?

        enum CodingKeys: String, CodingKey {
                case firstName = "first_name"
                case id = "id"
                case lastName = "last_name"
                case online = "online"
                case onlineInfo = "online_info"
                case photo100 = "photo_100"
                case photo50 = "photo_50"
                case screenName = "screen_name"
                case sex = "sex"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
//                id = try values.decodeIfPresent(Int.self, forKey: .id)
//                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
//                online = try values.decodeIfPresent(Int.self, forKey: .online)
//                onlineInfo = OnlineInfo(from: decoder)
//                photo100 = try values.decodeIfPresent(String.self, forKey: .photo100)
//                photo50 = try values.decodeIfPresent(String.self, forKey: .photo50)
//                screenName = try values.decodeIfPresent(String.self, forKey: .screenName)
//                sex = try values.decodeIfPresent(Int.self, forKey: .sex)
//        }

}

struct OnlineInfoNews : Codable {

        let isOnline : Bool?
        let visible : Bool?

        enum CodingKeys: String, CodingKey {
                case isOnline = "is_online"
                case visible = "visible"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                isOnline = try values.decodeIfPresent(Bool.self, forKey: .isOnline)
//                visible = try values.decodeIfPresent(Bool.self, forKey: .visible)
//        }

}

struct ItemNews : Codable {

        let attachments : [AttachmentNews]?
        let canDoubtCategory : Bool?
        let canSetCategory : Bool?
        let categoryAction : CategoryActionNews?
        let comments : CommentNews?
        let copyHistory : [CopyHistoryNews]?
        let date : Int?
        let likes : LikeNews?
        let markedAsAds : Int?
        let postId : Int?
        let postSource : PostSourceNews?
        let postType : String?
        let reposts : RepostNews?
        let sourceId : Int?
        let text : String?
        let topicId : Int?
        let type : String?

        enum CodingKeys: String, CodingKey {
                case attachments = "attachments"
                case canDoubtCategory = "can_doubt_category"
                case canSetCategory = "can_set_category"
                case categoryAction = "category_action"
                case comments = "comments"
                case copyHistory = "copy_history"
                case date = "date"
                case likes = "likes"
                case markedAsAds = "marked_as_ads"
                case postId = "post_id"
                case postSource = "post_source"
                case postType = "post_type"
                case reposts = "reposts"
                case sourceId = "source_id"
                case text = "text"
                case topicId = "topic_id"
                case type = "type"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                attachments = try values.decodeIfPresent([Attachment].self, forKey: .attachments)
//                canDoubtCategory = try values.decodeIfPresent(Bool.self, forKey: .canDoubtCategory)
//                canSetCategory = try values.decodeIfPresent(Bool.self, forKey: .canSetCategory)
//                categoryAction = CategoryAction(from: decoder)
//                comments = Comment(from: decoder)
//                copyHistory = try values.decodeIfPresent([CopyHistory].self, forKey: .copyHistory)
//                date = try values.decodeIfPresent(Int.self, forKey: .date)
//                likes = Like(from: decoder)
//                markedAsAds = try values.decodeIfPresent(Int.self, forKey: .markedAsAds)
//                postId = try values.decodeIfPresent(Int.self, forKey: .postId)
//                postSource = PostSource(from: decoder)
//                postType = try values.decodeIfPresent(String.self, forKey: .postType)
//                reposts = Repost(from: decoder)
//                sourceId = try values.decodeIfPresent(Int.self, forKey: .sourceId)
//                text = try values.decodeIfPresent(String.self, forKey: .text)
//                topicId = try values.decodeIfPresent(Int.self, forKey: .topicId)
//                type = try values.decodeIfPresent(String.self, forKey: .type)
//        }
//
}

struct RepostNews : Codable {

        let count : Int?
        let userReposted : Int?

        enum CodingKeys: String, CodingKey {
                case count = "count"
                case userReposted = "user_reposted"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                count = try values.decodeIfPresent(Int.self, forKey: .count)
//                userReposted = try values.decodeIfPresent(Int.self, forKey: .userReposted)
//        }

}

struct PostSourceNews : Codable {

        let type : String?

        enum CodingKeys: String, CodingKey {
                case type = "type"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                type = try values.decodeIfPresent(String.self, forKey: .type)
//        }

}

struct LikeNews : Codable {

        let canLike : Int?
        let canPublish : Int?
        let count : Int?
        let userLikes : Int?

        enum CodingKeys: String, CodingKey {
                case canLike = "can_like"
                case canPublish = "can_publish"
                case count = "count"
                case userLikes = "user_likes"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                canLike = try values.decodeIfPresent(Int.self, forKey: .canLike)
//                canPublish = try values.decodeIfPresent(Int.self, forKey: .canPublish)
//                count = try values.decodeIfPresent(Int.self, forKey: .count)
//                userLikes = try values.decodeIfPresent(Int.self, forKey: .userLikes)
//        }

}

struct CopyHistoryNews : Codable {

        let attachments : [AttachmentNews]?
        let date : Int?
        let fromId : Int?
        let id : Int?
        let ownerId : Int?
        let postSource : PostSourceNews?
        let postType : String?
        let text : String?

        enum CodingKeys: String, CodingKey {
                case attachments = "attachments"
                case date = "date"
                case fromId = "from_id"
                case id = "id"
                case ownerId = "owner_id"
                case postSource = "post_source"
                case postType = "post_type"
                case text = "text"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                attachments = try values.decodeIfPresent([Attachment].self, forKey: .attachments)
//                date = try values.decodeIfPresent(Int.self, forKey: .date)
//                fromId = try values.decodeIfPresent(Int.self, forKey: .fromId)
//                id = try values.decodeIfPresent(Int.self, forKey: .id)
//                ownerId = try values.decodeIfPresent(Int.self, forKey: .ownerId)
//                postSource = PostSource(from: decoder)
//                postType = try values.decodeIfPresent(String.self, forKey: .postType)
//                text = try values.decodeIfPresent(String.self, forKey: .text)
//        }

}

struct AttachmentNews : Codable {

        let photo : PhotoNews?
        let type : String?

        enum CodingKeys: String, CodingKey {
                case photo = "photo"
                case type = "type"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                photo = Photo(from: decoder)
//                type = try values.decodeIfPresent(String.self, forKey: .type)
//        }

}

struct PhotoNews : Codable {

        let accessKey : String?
        let albumId : Int?
        let date : Int?
        let height : Int?
        let id : Int?
        let ownerId : Int?
        let photo130 : String?
        let photo604 : String?
        let photo75 : String?
        let postId : Int?
        let text : String?
        let userId : Int?
        let width : Int?

        enum CodingKeys: String, CodingKey {
                case accessKey = "access_key"
                case albumId = "album_id"
                case date = "date"
                case height = "height"
                case id = "id"
                case ownerId = "owner_id"
                case photo130 = "photo_130"
                case photo604 = "photo_604"
                case photo75 = "photo_75"
                case postId = "post_id"
                case text = "text"
                case userId = "user_id"
                case width = "width"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                accessKey = try values.decodeIfPresent(String.self, forKey: .accessKey)
//                albumId = try values.decodeIfPresent(Int.self, forKey: .albumId)
//                date = try values.decodeIfPresent(Int.self, forKey: .date)
//                height = try values.decodeIfPresent(Int.self, forKey: .height)
//                id = try values.decodeIfPresent(Int.self, forKey: .id)
//                ownerId = try values.decodeIfPresent(Int.self, forKey: .ownerId)
//                photo130 = try values.decodeIfPresent(String.self, forKey: .photo130)
//                photo604 = try values.decodeIfPresent(String.self, forKey: .photo604)
//                photo75 = try values.decodeIfPresent(String.self, forKey: .photo75)
//                postId = try values.decodeIfPresent(Int.self, forKey: .postId)
//                text = try values.decodeIfPresent(String.self, forKey: .text)
//                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
//                width = try values.decodeIfPresent(Int.self, forKey: .width)
//        }

}

struct CommentNews : Codable {

        let canPost : Int?
        let count : Int?
        let groupsCanPost : Bool?

        enum CodingKeys: String, CodingKey {
                case canPost = "can_post"
                case count = "count"
                case groupsCanPost = "groups_can_post"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                canPost = try values.decodeIfPresent(Int.self, forKey: .canPost)
//                count = try values.decodeIfPresent(Int.self, forKey: .count)
//                groupsCanPost = try values.decodeIfPresent(Bool.self, forKey: .groupsCanPost)
//        }

}

struct CategoryActionNews : Codable {

        let action : ActionNews?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case action = "action"
                case name = "name"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                action = Action(from: decoder)
//                name = try values.decodeIfPresent(String.self, forKey: .name)
//        }

}

struct ActionNews : Codable {

        let target : String?
        let type : String?
        let url : String?

        enum CodingKeys: String, CodingKey {
                case target = "target"
                case type = "type"
                case url = "url"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                target = try values.decodeIfPresent(String.self, forKey: .target)
//                type = try values.decodeIfPresent(String.self, forKey: .type)
//                url = try values.decodeIfPresent(String.self, forKey: .url)
//        }

}

struct GroupNews : Codable {

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
