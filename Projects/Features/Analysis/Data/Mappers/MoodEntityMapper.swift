//
//  MoodEntityMapper.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/8/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation
import AnalysisDomain
import FirebaseCore
import FirebaseFirestore

public struct MoodEntityMapper {
    public static func toEntity(from data: [String: Any]) -> MoodEntity? {
        guard let mood = data["mood"] as? Int else {
            return nil
        }
        
        let time: Date
        
        if let timestamp = data["time"] as? Timestamp {
            time = timestamp.dateValue()
        } else {
            time = Date()
        }
        
        return MoodEntity(time: time, mood: mood)
    }
}
