//
//  Group.swift
//  HW2.1
//
//  Created by Илья Павлов on 09.01.2021.
//

import Foundation
import RealmSwift

class Group: Object, Decodable {
    @objc dynamic var groupID = 0.0
    @objc dynamic var groupName = ""
    @objc dynamic var groupIcon = ""
    
    enum CodingKeys: String, CodingKey {
        case groupID = "id"
        case groupName = "name"
        case groupIcon = "photo_50"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.groupID = try values.decode(Double.self, forKey: .groupID)
        self.groupName = try values.decode(String.self, forKey: .groupName)
        self.groupIcon = try values.decode(String.self, forKey: .groupIcon)
    }
}

class GroupList: Decodable {
    let items: [Group]
}

class GroupResponse: Decodable {
    let response : GroupList
}





