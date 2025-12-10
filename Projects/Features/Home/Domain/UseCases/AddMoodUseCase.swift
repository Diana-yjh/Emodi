//
//  AddMoodUseCase.swift
//  HomeData
//
//  Created by Yejin Hong on 12/5/25.
//

import Foundation

public protocol AddMoodUseCaseProtocol {
    func execute(mood: MoodEntity, photo: Data?, completion: @escaping (Result<Void, Error>) -> Void)
}

public final class AddMoodUseCase: AddMoodUseCaseProtocol {
    private let repository: MoodRepository
    
    public init(repository: MoodRepository) {
        self.repository = repository
    }
    
    public func execute(mood: MoodEntity, photo: Data?, completion: @escaping (Result<Void, any Error>) -> Void) {
        repository.addMoodDiary(mood: mood, photo: photo, completion: completion)
    }
}
