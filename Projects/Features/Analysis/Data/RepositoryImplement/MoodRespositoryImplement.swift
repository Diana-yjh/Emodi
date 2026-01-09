//
//  MoodRespositoryImplement.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation
import AnalysisDomain
import Core

public final class MoodRepositoryImplement: MoodRepository {
    var userID = UserManager.shared.userID
    
    private let firestoreService: FirestoreServiceProtocol
    
    public init(firestoreService: FirestoreServiceProtocol) {
        self.firestoreService = firestoreService
    }
    
    public func getMonthMood(startTime: Date, endTime: Date) async throws -> [MoodEntity] {
        let result = try await firestoreService.getDocuments(
            collection: "mood",
            filters: [
                FirestoreFilter(field: "time", op: .greaterThanOrEqual, value: startTime),
                FirestoreFilter(field: "time", op: .lessThan, value: endTime)
            ],
            orderBy: "time",
            descending: false
        )
        
        return result.documents.compactMap { doc -> MoodEntity? in
            guard let data = doc.data() else { return nil }
            return MoodEntityMapper.toEntity(from: data)
        }
    }
    
    public func getDateMood(selectedDate: Date) async throws -> [MoodEntity] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDate)
        let endOfDay = calendar.date(byAdding: DateComponents(day: 1, second: -1), to: startOfDay)!
        
        let result = try await firestoreService.getDocuments(
            collection: "mood",
            filters: [
                FirestoreFilter(field: "time", op: .greaterThanOrEqual, value: startOfDay),
                FirestoreFilter(field: "time", op: .lessThan, value: endOfDay)
            ],
            orderBy: "time",
            descending: false
        )
        
        return result.documents.compactMap { doc -> MoodEntity? in
            guard let data = doc.data() else { return nil }
            return MoodEntityMapper.toEntity(from: data)
        }
    }
}
