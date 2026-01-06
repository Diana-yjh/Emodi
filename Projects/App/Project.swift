//
//  Project.swift
//  Manifests
//
//  Created by Yejin Hong on 12/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Emodi",
    packages: [
        .firebase
    ],
    targets: [
        // MARK: - Main App
        .target(
            name: "Emodi",
            destinations: Environment.destinations,
            product: .app,
            bundleId: "\(Environment.bundleIdPrefix).emodi",
            deploymentTargets: Environment.deploymentTarget,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIImageName": "LaunchImage"
                    ],
                    "CFBundleDisplayName": "Emodi",
                    "NSPhotoLibraryUsageDescription": "Emodi가 사진 기록을 위해 앨범 접근하는 것을 허용하시겠습니까?",
                    "NSPhotoLibraryAddUsageDescription": "Emodi가 사진 기록을 위해 앨범 접근하는 것을 허용하시겠습니까?"
                ]
            ),
            sources: ["Sources/**"],
            resources: [
                "Resources/**",
                "GoogleService-Info.plist"  // Firebase 설정 파일
            ],
            dependencies: [
                // Core (Firebase 포함)
                .Module.core,
                
                // Features
                .Splash.splash,
                
                // Firebase Auth는 App에서도 직접 사용 (로그인 처리)
                .firebaseAuth
            ]
        ),
        
        // MARK: - Unit Tests
        .target(
            name: "EmodiTest",
            destinations: Environment.destinations,
            product: .unitTests,
            bundleId: "\(Environment.bundleIdPrefix).emodiTest",
            deploymentTargets: Environment.deploymentTarget,
            infoPlist: .default,
            sources: [],
            resources: [],
            dependencies: [.target(name: "Emodi")]
        ),
    ]
)
