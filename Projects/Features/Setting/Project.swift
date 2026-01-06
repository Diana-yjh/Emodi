//
//  Project.swift
//  Config
//
//  Created by Yejin Hong on 12/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Setting",
    targets: [
        // MARK: - SettingDomain
        .makeTarget(
            name: "SettingDomain",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).setting.domain",
            sources: ["Domain/**"],
            dependencies: []
        ),
        
        // MARK: - SettingData
        .makeTarget(
            name: "SettingData",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).setting.data",
            sources: ["Data/**"],
            dependencies: [
                .target(name: "SettingDomain"),
                .Module.core  // Firebase 필요시 Core를 통해 접근
            ]
        ),
        
        // MARK: - SettingPresentation
        .makeTarget(
            name: "SettingPresentation",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).setting.presentation",
            sources: ["Presentation/**"],
            dependencies: [
                .target(name: "SettingDomain"),
                .Module.designSystem
            ]
        )
    ]
)
