//
//  MoodRepository.swift
//  HomeData
//
//  Created by Yejin Hong on 12/10/25.
//

import Foundation

public protocol MoodRepository {
    func addMoodDiary(mood: MoodEntity) async throws
    func fetchMoodDiary(date: String) async throws -> [FetchMoodEntity?]
    func deleteMoodDiary(diaryId: String) async throws
    
    func uploadImage(imageData: [Data: String]) async throws -> [String]
}
