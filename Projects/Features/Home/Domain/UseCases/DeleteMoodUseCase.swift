//
//  DeleteMoodUseCase.swift
//  HomeData
//
//  Created by Yejin Hong on 12/10/25.
//

import Foundation

public protocol DeleteMoodUseCaseProtocol {
    func execute(date: Date, diaryID: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

public final class DeleteMoodUseCase: DeleteMoodUseCaseProtocol {
    private let repository: MoodRepository
    
    init(repository: MoodRepository) {
        self.repository = repository
    }
    
    public func execute(date: Date, diaryID: Int, completion: @escaping (Result<Void, any Error>) -> Void) {
        repository.deleteMoodDiary(date: date, diaryID: diaryID, completion: completion)
    }
}
