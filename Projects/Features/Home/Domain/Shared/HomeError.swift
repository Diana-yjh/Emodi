//
//  EmodiError.swift
//  HomeComposition
//
//  Created by Yejin Hong on 12/30/25.
//

import Foundation

@frozen public enum HomeResult<Success, HomeError> where HomeError : Error {
    case success(Success)
    case failure(HomeError)
}

public enum HomeError: Error {
    case addMoodDiaryFailed
    case fetchMoodDiaryFailed
    case deleteMoodDiaryFailed
}
