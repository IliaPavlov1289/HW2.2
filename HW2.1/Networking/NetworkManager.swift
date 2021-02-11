//
//  NetworkManager.swift
//  HW2.1
//
//  Created by Илья Павлов on 11.02.2021.
//

import Foundation
import Alamofire

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
    
    static func loadUserGroups(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            
            print(json)
        }
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
    
    static func loadUserFriends(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    static func loadUserPhotos(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
}
