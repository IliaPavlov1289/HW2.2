//
//  FirebaseUser.swift
//  HW2.1
//
//  Created by Илья Павлов on 22.03.2021.
//

import Foundation
import FirebaseDatabase

class FirebaseUser {
    let userID: Int
    let userName: String
    let userLastName: String
    let userIcon: String
    
    let ref: DatabaseReference?
    
    init(userID: Int,
         userName: String,
         userLastName: String,
         userIcon: String) {
        
        self.userID = userID
        self.userName = userName
        self.userLastName = userLastName
        self.userIcon = userIcon
        
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard
            let value = snapshot.value as? [String: Any],
            let userID = value["userID"] as? Int,
            let userName = value["userName"] as? String,
            let userLastName = value["userLastName"] as? String,
            let userIcon = value["userIcon"] as? String
        else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.userID = userID
        self.userName = userName
        self.userLastName = userLastName
        self.userIcon = userIcon
            
    }
    
    init?(dict: [String: Any]) {
        guard let userID = dict["userID"] as? Int,
              let userName = dict["userName"] as? String,
              let userLastName = dict["userLastName"] as? String,
              let userIcon = dict["userIcon"] as? String else { return nil }
        
        self.userID = userID
        self.userName = userName
        self.userLastName = userLastName
        self.userIcon = userIcon
        
        self.ref = nil
    }
    
    //Convert from Group
    convenience init(fromUser: User) {
        let userID = fromUser.userID
        let userName = fromUser.userName
        let userLastName = fromUser.userLastName
        let userIcon = fromUser.userIcon
        
        self.init(userID: userID,
                  userName: userName,
                  userLastName: userLastName,
                  userIcon: userIcon)
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "userID": userID,
            "userName": userName,
            "userLastName": userLastName,
            "userIcon": userIcon
        ]
    }
    
}
