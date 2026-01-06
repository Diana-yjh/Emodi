//
//  MoodRemoteDataSource.swift
//  HomeComposition
//
//  Created by Yejin Hong on 1/2/26.
//

import HomeDomain

public protocol MoodRemoteDataSource {
    func createMood(_ mood: MoodEntity) async throws
    func fetchMoodList(date: String) async throws -> [FetchMoodEntity]
    func deleteMood(userID: String, diaryID: String, date: String) async throws
}
