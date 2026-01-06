//
//  PhotoRepositoryImplement.swift
//  HomeData
//
//  Created by Yejin Hong on 12/26/25.
//

import HomeDomain
import Photos
import UIKit

public final class PhotoRepositoryImplement: PhotoRepository {
    public init() {}
    
    public func authorizationStatus() -> PhotoAuthorizationStatus {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .notDetermined:
            return .notDetermined
        case .authorized:
            return .authorized
        case .limited:
            return .limited
        case .denied, .restricted:
            return .denied
        @unknown default:
            return .denied
        }
    }
    
    public func requestPhotoAccess() -> PhotoAuthorizationStatus {
        var result: PhotoAuthorizationStatus = .denied
        
        let semaphore = DispatchSemaphore(value: 0)
        
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            result = self.map(status)
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    public func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url)
    }
    
    private func map(_ status: PHAuthorizationStatus) -> PhotoAuthorizationStatus {
        switch status {
        case .authorized: return .authorized
        case .limited: return .limited
        case .notDetermined: return .notDetermined
        default: return .denied
        }
    }
}
