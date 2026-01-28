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
    private var diaryID: String? = nil
    
    public init(firestoreService: FirestoreServiceProtocol) {
        self.firestoreService = firestoreService
    }
    
    public func updateMood(_ mood: MoodEntity) async throws {
        if let id = mood.diaryId {
            diaryID = id
        }
        
        try await firestoreService.addDocument(
            collection: FirebaseCollection.collection.key,
            documentId: UserManager.shared.userID,
            subcollection: FirebaseCollection.subcollection.key,
            diaryId: diaryID ?? UUID().uuidString,
            data: [
                "time": mood.time,
                "date": mood.date,
                "mood": mood.mood,
                "memo": mood.memo,
                "photo_url": mood.photoURL ?? ""
            ]
        )
    }
    
    public func fetchMoodList(date: String) async throws -> [FetchMoodEntity] {
        let result = try await firestoreService.getDocuments(
            collection: FirebaseCollection.collection.key,
            documentId: UserManager.shared.userID,
            subcollection: FirebaseCollection.subcollection.key,
            filters: [
                FirestoreFilter(field: "date", op: .equal, value: date)
            ],
            orderBy: "time",
            descending: false
        )
        
        return result.documents.compactMap { doc -> FetchMoodEntity? in
            guard let data = doc.data() else { return nil }
            let diaryId = doc.documentID
            return MoodEntityMapper.toEntity(from: data, diaryId: diaryId)
        }
    }
    
    public func deleteMood(diaryID: String) async throws {
        try await firestoreService.deleteDocuments(
            collection: FirebaseCollection.collection.key,
            documentId: UserManager.shared.userID,
            subcollection: FirebaseCollection.subcollection.key,
            diaryId: diaryID
        )
    }
}
