//
//  MoodUseCase.swift
//  HomeData
//
//  Created by Yejin Hong on 12/5/25.
//

import Foundation

public protocol MoodUseCaseProtocol {
    func addMoodDiary(mood: MoodEntity) async throws
    func fetchMoodDiary(date: String, userID: String) async throws -> [MoodEntity]
    func deleteMoodDiary(date: String, userID: String, diaryID: Int) async throws
}

public final class MoodUseCase: MoodUseCaseProtocol {
    private let repository: MoodRepository
    
    public init(repository: MoodRepository) {
        self.repository = repository
    }
    
    public func addMoodDiary(mood: MoodEntity) async throws {
        try await repository.addMoodDiary(mood: mood)
    }
    
    public func fetchMoodDiary(date: String, userID: String) async throws -> [MoodEntity] {
        try await repository.fetchMoodDiary(date: date, userID: userID)
    }
    
    public func deleteMoodDiary(date: String, userID: String, diaryID: Int) async throws {
        try await repository.deleteMoodDiary(date: date, userID: userID, diaryID: diaryID)
    }
}
