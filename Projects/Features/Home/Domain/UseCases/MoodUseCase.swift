//
//  MoodUseCase.swift
//  HomeData
//
//  Created by Yejin Hong on 12/5/25.
//

import Foundation

public protocol MoodUseCaseProtocol {
    func addMoodDiary(mood: MoodEntity) async throws
    func fetchMoodDiary(date: String) async throws -> [FetchMoodEntity?]
    func deleteMoodDiary(date: String) async throws
}

public final class MoodUseCase: MoodUseCaseProtocol {
    private let repository: MoodRepository
    
    public init(repository: MoodRepository) {
        self.repository = repository
    }
    
    public func addMoodDiary(mood: MoodEntity) async throws {
        try await repository.addMoodDiary(mood: mood)
    }
    
    public func fetchMoodDiary(date: String) async throws -> [FetchMoodEntity?] {
        try await repository.fetchMoodDiary(date: date)
    }
    
    public func deleteMoodDiary(date: String) async throws {
        try await repository.deleteMoodDiary(date: date)
    }
}
