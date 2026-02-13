//
//  FirebaseStorageProtocol.swift
//  Core
//
//  Created by Yejin Hong on 1/28/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

public enum FirebaseStorageError: Error {
    case compressionFailed
}

public struct FirebaseStorageResult: Sendable {
    public let urls: [String]
}

public protocol FirebaseStorageProtocol: Sendable {
    func uploadImage(_ imageData: [Data: String]) async throws -> FirebaseStorageResult
    func deleteImage(_ images: [String]) async throws
}
