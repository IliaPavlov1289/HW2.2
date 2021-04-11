//
//  NewsPost.swift
//  HW2.1
//
//  Created by Илья Павлов on 07.04.2021.
//

import Foundation

class NewsResponse: Decodable {
    
    let response: NewsList
}

class NewsList: Decodable {
    
    let items: [NewsPost]
    let profiles: [User]
    let groups: [Group]
}

class NewsPost: Decodable{
   
    let senderID: Int
    let text: String
    let attachments: [Attachment]?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
    
    enum CodingKeys: String, CodingKey {
        case senderID = "source_id"
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
    }
    
}

class Comments: Decodable {
    let count: Int
}

class Likes: Decodable {
    let count: Int
    let user_likes: Int
}

class Reposts: Decodable {
    let count: Int
    let user_reposted: Int
}

class Views: Decodable {
    let count: Int
}

class Attachment: Decodable {
    let photo: PostPhotoSizes?
}

class PostPhotoSizes: Decodable {
    let sizes: [PhotoUrl]
}

class PhotoUrl: Decodable {
    let url: String
}
