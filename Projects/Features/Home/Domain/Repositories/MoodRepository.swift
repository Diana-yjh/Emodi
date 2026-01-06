//
//  MoodRepository.swift
//  HomeData
//
//  Created by Yejin Hong on 12/10/25.
//

import Foundation

public protocol MoodRepository {
    func addMoodDiary(mood: MoodEntity) async throws
    func fetchMoodDiary(date: String, userID: String) async throws -> [MoodEntity]
    func deleteMoodDiary(date: String, userID: String, diaryID: Int) async throws
}
