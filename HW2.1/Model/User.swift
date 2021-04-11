//
//  User.swift
//  HW2.1
//
//  Created by Илья Павлов on 09.01.2021.
//

import Foundation
import RealmSwift


class User: Object, Decodable {
    @objc dynamic var userID = 0
    @objc dynamic var userName = ""
    @objc dynamic var userLastName = ""
    @objc dynamic var userIcon = ""
    
    override class func primaryKey() -> String? {
        "userID"
    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case userName = "first_name"
        case userLastName = "last_name"
        case userIcon = "photo_50"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try values.decode(Int.self, forKey: .userID)
        self.userName = try values.decode(String.self, forKey: .userName)
        self.userLastName = try values.decode(String.self, forKey: .userLastName)
        self.userIcon = try values.decode(String.self, forKey: .userIcon)
    }
}

class UserList: Decodable {
    let items: [User]
}

class UserResponse: Decodable {
    let response : UserList
}

