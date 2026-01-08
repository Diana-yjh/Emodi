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
            "time": mood.time,
            "date": mood.date,
            "mood": mood.mood,
            "memo": mood.memo,
            "photo_url": mood.photoURL ?? ""
        ])
    }
    
    public func fetchMoodList(date: String) async throws -> [FetchMoodEntity] {
        let result = try await firestoreService.getDocuments(
            collection: "mood",
            filters: [
                FirestoreFilter(field: "user_id", op: .equal, value: UserManager.shared.userID),
                FirestoreFilter(field: "date", op: .equal, value: date)
            ],
            orderBy: "time",
            descending: false
        )
        
        return result.documents.compactMap { doc -> FetchMoodEntity? in
            guard let data = doc.data() else { return nil }
            return MoodEntityMapper.toEntity(from: data)
        }
    }
    
    public func deleteMood(userID: String, diaryID: String, date: String) async throws {
        try await firestoreService.deleteDocuments(
            collection: "mood",
            filters: [
                (field: "user_id", value: userID),
                (field: "diary_id", value: diaryID),
                (field: "date", value: date)
            ]
        )
    }
}
