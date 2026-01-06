//
//  EmodiError.swift
//  HomeComposition
//
//  Created by Yejin Hong on 12/30/25.
//

import Foundation

@frozen public enum EmodiResult<Success, EmodiError> where EmodiError : Error {
    case success(Success)
    case failure(EmodiError)
}

public enum EmodiError: Error {
    case addMoodDiaryFailed
    case fetchMoodDiaryFailed
    case deleteMoodDiaryFailed
}
