//
//  MoodRemoteDataSource.swift
//  HomeComposition
//
//  Created by Yejin Hong on 1/2/26.
//

import HomeDomain

public protocol MoodRemoteDataSource {
    func createMood(_ mood: MoodEntity) async throws
    func fetchMoodList(userID: String, date: String) async throws -> [MoodEntity]
//    func deleteMood(userID: Int, diaryID: Int, date: String) async throws
}
