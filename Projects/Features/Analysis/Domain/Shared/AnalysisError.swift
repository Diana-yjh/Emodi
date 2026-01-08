//
//  AnalysisError.swift
//  HomeComposition
//
//  Created by Yejin Hong on 1/8/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

@frozen public enum AnalysisResult<Success, AnalysisError> where AnalysisError : Error {
    case success(Success)
    case failure(AnalysisError)
}

public enum AnalysisError: Error {
    case getMoodDateFailed
}
