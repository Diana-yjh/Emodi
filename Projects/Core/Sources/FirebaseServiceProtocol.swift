//
//  FirebaseServiceProtocol.swift
//  Core
//
//  Created by Yejin Hong on 1/5/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

// MARK: - Firestore Document Protocol
public protocol FirestoreDocumentProtocol: Sendable {
    var documentID: String { get }
    func data() -> [String: Any]?
}

public struct FirestoreDocument: FirestoreDocumentProtocol, Sendable {
    public let documentID: String
    private let _data: [String: Any]?
    
    public init(documentID: String, data: [String: Any]?) {
        self.documentID = documentID
        self._data = data
    }
    
    public func data() -> [String: Any]? {
        return _data
    }
}

// MARK: - Firestore Query Result
public struct FirestoreQueryResult: Sendable {
    public let documents: [FirestoreDocumentProtocol]
}

// MARK: - Firestore Service Protocol
public protocol FirestoreServiceProtocol: Sendable {
    func addDocument(collection: String, data: [String: Any]) async throws
    
    func getDocuments(
        collection: String,
        filters: [FirestoreFilter],
        orderBy: String?,
        descending: Bool
    ) async throws -> FirestoreQueryResult
    
    func deleteDocuments(
        collection: String,
        filters: [(field: String, value: Any)]
    ) async throws
}
