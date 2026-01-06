//
//  PhotoRepository.swift
//  HomeDomain
//
//  Created by Yejin Hong on 12/26/25.
//

import Foundation

public enum PhotoAuthorizationStatus {
    case notDetermined
    case authorized
    case denied
    case limited
}

public protocol PhotoRepository {
    func authorizationStatus() -> PhotoAuthorizationStatus
    func requestPhotoAccess() -> PhotoAuthorizationStatus
    func openAppSettings()
}
