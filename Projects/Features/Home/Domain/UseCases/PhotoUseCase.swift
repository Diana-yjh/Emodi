//
//  PhotoUseCase.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/24/25.
//

import Foundation

public protocol PhotoUseCaseProtocol {
    func requestAccess() -> PhotoAuthorizationStatus
    func openSettings()
}

public final class PhotoUseCase: PhotoUseCaseProtocol {
    private let repository: PhotoRepository

    public init(repository: PhotoRepository) {
        self.repository = repository
    }

    public func requestAccess() -> PhotoAuthorizationStatus {
        let status = repository.authorizationStatus()

        switch status {
        case .notDetermined:
            return repository.requestPhotoAccess()

        case .authorized, .limited:
            return status

        case .denied:
            return .denied
        }
    }

    public func openSettings() {
        repository.openAppSettings()
    }
}
