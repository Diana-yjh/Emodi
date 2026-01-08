//
//  FirebaseStore.swift
//  Core
//
//  Created by Yejin Hong on 1/5/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation
import FirebaseFirestore

public struct FirestoreFilter {
    let field: String
    let op: QueryOperator
    let value: Any
    
    public init(field: String, op: QueryOperator, value: Any) {
        self.field = field
        self.op = op
        self.value = value
    }
}

public enum QueryOperator {
    case equal
    case greaterThanOrEqual
    case lessThan
}

public final class FirestoreService: FirestoreServiceProtocol, @unchecked Sendable {
    private var db: Firestore
    
    public init(firestore: Firestore = Firestore.firestore(database: "emodi")) {
        self.db = firestore
    }
    
    public func addDocument(
        collection: String,
        data: [String: Any]
    ) async throws {
        try await db.collection(collection).addDocument(data: data)
    }
    
    public func getDocuments(
        collection: String,
        filters: [FirestoreFilter],
        orderBy: String?,
        descending: Bool
    ) async throws -> FirestoreQueryResult {
        var query: Query = db.collection(collection)
        
        for filter in filters {
            switch filter.op {
            case .equal:
                query = query.whereField(filter.field, isEqualTo: filter.value)
            case .greaterThanOrEqual:
                query = query.whereField(filter.field, isGreaterThanOrEqualTo: filter.value)
            case .lessThan:
                query = query.whereField(filter.field, isLessThan: filter.value)
            }
        }
        
        if let orderField = orderBy {
            query = query.order(by: orderField, descending: descending)
        }
        
        let snapshot = try await query.getDocuments()
        let documents = snapshot.documents.map { doc in
            FirestoreDocument(documentID: doc.documentID, data: doc.data())
        }
        
        return FirestoreQueryResult(documents: documents)
    }
    
    public func deleteDocuments(collection: String, filters: [(field: String, value: Any)]) async throws {
        
    }
}
