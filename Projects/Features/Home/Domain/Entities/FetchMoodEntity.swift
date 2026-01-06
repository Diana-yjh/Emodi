//
//  FetchMoodEntity.swift
//  HomeDomain
//
//  Created by Yejin Hong on 1/6/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

public struct FetchMoodEntity: Codable, Equatable, Sendable {
    public let userID: String
    public let diaryID: String
    public let time: Date
    public let date: String
    public let mood: Int
    public let memo: String
    public let photoURL: String?
    
    public init(userID: String, diaryID: String, time: Date, date: String, mood: Int, memo: String, photoURL: String?) {
        self.userID = userID
        self.diaryID = diaryID
        self.time = time
        self.date = date
        self.mood = mood
        self.memo = memo
        self.photoURL = photoURL
    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case diaryID = "diary_id"
        case time
        case date
        case mood
        case memo
        case photoURL
    }
}
