//
//  Photo.swift
//  HW2.1
//
//  Created by Илья Павлов on 28.02.2021.
//

import Foundation
import RealmSwift

class Photo: Object, Decodable {
    @objc dynamic var photoUrl = ""
    
    enum CodingKeys: String, CodingKey {
        case photoUrl = "url"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.photoUrl = try values.decode(String.self, forKey: .photoUrl)
    }
}

class PhotoSizes: Object, Decodable {
    @objc dynamic var id = 0
    var sizes = List<Photo>()

    override class func primaryKey() -> String? {
        "id"
    }
}

class PhotoList: Decodable {
    let items: [PhotoSizes]
}

class PhotoResponse: Decodable {
    let response : PhotoList
}
