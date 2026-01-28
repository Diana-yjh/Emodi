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
        try await remoteDataSource.updateMood(mood)
    }
    
    public func fetchMoodDiary(date: String) async throws -> [FetchMoodEntity?] {
        let result = try await remoteDataSource.fetchMoodList(date: date)
        
        return result
    }
    
    public func deleteMoodDiary(diaryId: String) async throws {
        try await remoteDataSource.deleteMood(diaryID: diaryId)
    }
}
