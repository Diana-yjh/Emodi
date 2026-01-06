//
//  MoodRepositoryImplement.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/29/25.
//

import HomeDomain
import Foundation

public final class MoodRepositoryImplement: MoodRepository {
    public let remoteDataSource: MoodRemoteDataSource
    
    public init(remoteDataSource: MoodRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func addMoodDiary(mood: MoodEntity) async throws {
        try await remoteDataSource.createMood(mood)
    }
    
    public func fetchMoodDiary(date: String, userID: String) async throws -> [MoodEntity] {
        let result = try await remoteDataSource.fetchMoodList(userID: userID, date: date)
        
        return result
    }
    
    public func deleteMoodDiary(date: String, userID: String, diaryID: Int) async throws {
//        try await remoteDataSource.deleteMood(userID: userID, diaryID: diaryID, date: date)
    }
}
