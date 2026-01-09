//
//  MoodRepository.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

public protocol MoodRepository {
    func getMonthMood(startTime: Date, endTime: Date) async throws -> [MoodEntity]
    func getDateMood(selectedDate: Date) async throws -> [MoodEntity]
}
