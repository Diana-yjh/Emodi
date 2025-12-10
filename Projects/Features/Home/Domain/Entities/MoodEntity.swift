//
//  MoodEntity.swift
//  HomeData
//
//  Created by Yejin Hong on 12/10/25.
//

import Foundation

public struct MoodEntity: Codable, Equatable {
    public let diaryID: Int
    public let date: Date
    public let mood: Int
    public let memo: String?
    public let photoURL: String?
    
    public init(diaryID: Int, date: Date, mood: Int, memo: String?, photoURL: String?) {
        self.diaryID = diaryID
        self.date = date
        self.mood = mood
        self.memo = memo
        self.photoURL = photoURL
    }
}
