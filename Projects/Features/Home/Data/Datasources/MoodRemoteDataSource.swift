//
//  MoodRemoteDataSource.swift
//  HomeComposition
//
//  Created by Yejin Hong on 1/2/26.
//

import HomeDomain
import SwiftUI

public protocol MoodRemoteDataSource {
    func updateMood(_ mood: MoodEntity) async throws
    func fetchMoodList(date: String) async throws -> [FetchMoodEntity]
    func deleteMood(diaryID: String) async throws
    
    func uploadImage(_ imageData: [Data: String]) async throws -> [String]
}
