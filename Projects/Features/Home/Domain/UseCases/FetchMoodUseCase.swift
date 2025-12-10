//
//  FetchMoodUseCase.swift
//  HomeData
//
//  Created by Yejin Hong on 12/10/25.
//

import Foundation

public protocol FetchMoodUseCaseProtocol {
    func execute(date: Date, completion: @escaping (Result<[MoodEntity], Error>) -> Void)
}

public final class FetchMoodUseCase: FetchMoodUseCaseProtocol {
    private let repository: MoodRepository
    
    public init(repository: MoodRepository) {
        self.repository = repository
    }
    
    public func execute(date: Date, completion: @escaping (Result<[MoodEntity], Error>) -> Void) {
        repository.fetchMoodDiary(date: date, completion: completion)
    }
}
