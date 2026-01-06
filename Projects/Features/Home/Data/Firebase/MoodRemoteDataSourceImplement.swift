//
//  MoodRemoteDataSourceImplement.swift
//  HomeComposition
//
//  Created by Yejin Hong on 1/2/26.
//

import Foundation
import HomeDomain
import Core

public final class MoodRemoteDataSourceImplement: MoodRemoteDataSource {
    private let firestoreService: FirestoreServiceProtocol
    private let diaryID: String = UUID().uuidString
    
    public init(firestoreService: FirestoreServiceProtocol) {
        self.firestoreService = firestoreService
    }
    
    public func createMood(_ mood: MoodEntity) async throws {
        try await firestoreService.addDocument(collection: "mood", data: [
            "user_id": UserManager.shared.userID,
            "diary_id": diaryID,
            "date": mood.date,
            "time": mood.time,
            "mood": mood.mood,
            "memo": mood.memo,
            "photo_url": mood.photoURL ?? ""
        ])
    }
    
    public func fetchMoodList(userID: String, date: String) async throws -> [MoodEntity] {
        let result = try await firestoreService.getDocuments(
            collection: "emodi",
            filters: [
                (field: "user_id", value: userID),
                (field: "date", value: date)
            ],
            orderBy: "time",
            descending: true
        )
        
        return [.init(date: "", time: "", mood: 0, memo: "", photoURL: "")]
    }
}
