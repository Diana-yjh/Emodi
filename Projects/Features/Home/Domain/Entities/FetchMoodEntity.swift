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
    public let date: String
    public let time: String
    public let mood: Int
    public let memo: String
    public let photoURL: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case diaryID = "diary_id"
        case date
        case time
        case mood
        case memo
        case photoURL
    }
}
