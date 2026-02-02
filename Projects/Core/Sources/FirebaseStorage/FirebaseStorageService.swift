//
//  FirebaseStorageService.swift
//  Core
//
//  Created by Yejin Hong on 1/28/26.
//  Copyright © 2026 diana. All rights reserved.
//

import FirebaseStorage
import Foundation

public final class FirebaseStorageService: FirebaseStorageProtocol, @unchecked Sendable {
    public init() {}
    
    public func uploadImage(_ imageData: [Data: String]) async throws -> FirebaseStorageResult {
        let storageRef = Storage.storage().reference()
        let metadata = StorageMetadata()
        var savedUrls: [String] = []
        
        metadata.contentType = "image/jpeg"
        var index = 0
        
        for image in imageData {
            index += 1
            
            let path = image.value
            let imagePath = UserManager.shared.userID.prefix(8) + "/\(index)_" + path
            let imageRef = storageRef.child(imagePath)
            
            _ = try await imageRef.putDataAsync(image.key, metadata: metadata)
            
            let url = try await imageRef.downloadURL()
            
            savedUrls.append(url.absoluteString)
        }
        
        return FirebaseStorageResult(urls: savedUrls)
    }
    
//    public func loadImages() async throws -> [Data] {
//        let storageRef = Storage.storage().reference()
//        storageRef.getData(maxSize: <#T##Int64#>, completion: <#T##(Result<Data, any Error>) -> Void#>)
//    }
}
