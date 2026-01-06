//
//  MoodEntity.swift
//  HomeData
//
//  Created by Yejin Hong on 12/10/25.
//

import Foundation

public struct MoodEntity: Codable, Equatable, Sendable {
    public let date: String
    public let time: String
    public let mood: Int
    public let memo: String
    public let photoURL: String?
    
    public init(date: String, time: String, mood: Int, memo: String?, photoURL: String?) {
        self.date = date
        self.time = time
        self.mood = mood
        self.memo = memo ?? ""
        self.photoURL = photoURL
    }
}
