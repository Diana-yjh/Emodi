//
//  MoodEntity.swift
//  AnalysisData
//
//  Created by Yejin Hong on 12/9/25.
//

import Foundation

public struct MoodEntity {
    var time: Date
    var mood: Int
    
    public init(time: Date, mood: Int) {
        self.time = time
        self.mood = mood
    }
    
    public func getTime() -> Date {
        return time
    }
}
