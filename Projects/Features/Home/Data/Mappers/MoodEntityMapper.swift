//
//  MoodEntityMapper.swift
//  HomeDomain
//
//  Created by Yejin Hong on 1/6/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation
import HomeDomain
import FirebaseCore
import FirebaseFirestore

public struct MoodEntityMapper {
    public static func toEntity(from data: [String: Any]) -> FetchMoodEntity? {
        guard let userID = data["user_id"] as? String,
              let diaryID = data["diary_id"] as? String,
              let date = data["date"] as? String,
              let mood = data["mood"] as? Int,
              let memo = data["memo"] as? String
        else {
            return nil
        }
        
        let time: Date
        
        if let timestamp = data["time"] as? Timestamp {
            time = timestamp.dateValue()
        } else {
            time = Date()
        }
        
        return FetchMoodEntity(
            userID: userID,
            diaryID: diaryID,
            time: time,
            date: date,
            mood: mood,
            memo: memo,
            photoURL: data["photo_url"] as? String
        )
    }
}
