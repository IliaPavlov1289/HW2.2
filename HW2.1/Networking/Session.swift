//
//  NetworkManager.swift
//  HW2.1
//
//  Created by Илья Павлов on 06.02.2021.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    var token: String = ""
    var userID: Int = 0
    
    private init() {
        
    }
    
}
