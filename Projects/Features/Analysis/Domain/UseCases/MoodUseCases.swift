//
//  MoodUseCases.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

public protocol MoodUseCaseProtocol {
    func getMonthMood(startTime: Date, endTime: Date) async throws -> [MoodEntity]
}

public final class MoodUseCases: MoodUseCaseProtocol {
    private let repository: MoodRepository
    
    public init(repository: MoodRepository) {
        self.repository = repository
    }
    
    public func getMonthMood(startTime: Date, endTime: Date) async throws -> [MoodEntity] {
        try await repository.getMonthMood(startTime: startTime, endTime: endTime)
    }
}
