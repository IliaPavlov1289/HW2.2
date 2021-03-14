//
//  NetworkManager.swift
//  HW2.1
//
//  Created by Илья Павлов on 11.02.2021.
//

import Foundation
import Alamofire
import RealmSwift


class NetworkManager {

    private static let sessionAF: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        let session = Alamofire.Session(configuration: configuration)
    
        return session
    }()

    static let shared = NetworkManager()

    private init() {
    
    }
    
    static func loadSearchGroups(token: String,searchText: String ) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q": searchText,
            "type": "group",
            "v": "5.92"
        ]
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            
            print(json)
        }
    }

    static func saveData<T: Object>(_ data: [T]) {
        do {
            let realm = try Realm()
            let oldDate = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldDate)
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    static func loadUserGroups(token: String, completion: @escaping ([Group]) -> Void) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"

        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92"
        ]

        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { response in
            guard let data = response.value else {return}

            let groups = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
            
            self.saveData(groups)
            
            completion(groups)
        }
    }
    
    static func loadUserFriends(token: String, completion: @escaping ([User]) -> Void) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "v": "5.92",
            "fields": "nickname,photo_50"
        ]
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }
            
            let users = try! JSONDecoder().decode(UserResponse.self, from: data).response.items
            
            self.saveData(users)
            
            completion(users)
                   
        }
    }
    
    static func loadUserPhotos(token: String, userID: Int, completion: @escaping ([PhotoSizes]) -> Void) {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token": token,
            "owner_id": userID,
//            "extended": 1,
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }
            
            let photos = try! JSONDecoder().decode(PhotoResponse.self, from: data).response.items
            
            self.saveData(photos)
            
            completion(photos)
            
        }
    }
}
