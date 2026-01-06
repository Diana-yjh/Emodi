//
//  UserManager.swift
//  Core
//
//  Created by Yejin Hong on 1/6/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

public final class UserManager {
    public static let shared = UserManager()
    
    private let userIDKey = "emodi_user_id"
    
    private init() {}
    
    public var userID: String {
        if let existingID = UserDefaults.standard.string(forKey: userIDKey) {
            return existingID
        }
        
        let newID = UUID().uuidString
        UserDefaults.standard.set(newID, forKey: userIDKey)
        print("새 유저 생성: \(newID)")
        return newID
    }
    
    public func resetUser() {
        UserDefaults.standard.removeObject(forKey: userIDKey)
        print("유저 초기화됨")
    }
}
