//
//  FirebaseStore.swift
//  Core
//
//  Created by Yejin Hong on 1/5/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation
import FirebaseFirestore

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
        filters: [(field: String, value: Any)],
        orderBy: String?,
        descending: Bool
    ) async throws -> FirestoreQueryResult {
        var query: Query = db.collection(collection)
        
        for filter in filters {
            query = query.whereField(filter.field, isEqualTo: filter.value)
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
