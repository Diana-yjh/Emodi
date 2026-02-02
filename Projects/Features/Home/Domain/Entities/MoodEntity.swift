//
//  MoodEntity.swift
//  HomeData
//
//  Created by Yejin Hong on 12/10/25.
//

import Foundation

public struct MoodEntity: Codable, Equatable, Sendable {
    public let diaryId: String?
    public let time: Date
    public let date: String
    public let mood: Int
    public let memo: String
    public let photoURL: [String]?
    
    public init(diaryId: String? = nil, time: Date, date: String, mood: Int, memo: String?, photoURL: [String]?) {
        self.diaryId = diaryId
        self.time = time
        self.date = date
        self.mood = mood
        self.memo = memo ?? ""
        self.photoURL = photoURL
    }
}
