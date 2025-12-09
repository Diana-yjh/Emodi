//
//  Project.swift
//  Config
//
//  Created by Yejin Hong on 12/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Setting",
    targets: [
        .target(
            name: "SettingDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: .appIdentifier + "SettingDomain",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Domain/**"],
            resources: [],
            dependencies: []
        ),
        .target(
            name: "SettingData",
            destinations: .iOS,
            product: .framework,
            bundleId: .appIdentifier + "SettingData",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Data/**"],
            resources: [],
            dependencies: [
                .target(name: "SettingDomain")
            ]
        ),
        .target(
            name: "SettingPresentation",
            destinations: Environment.destinations,
            product: .framework,
            bundleId: .appIdentifier + "SettingPresentation",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Presentation/**"],
            resources: [],
            dependencies: [
                .target(name: "SettingDomain"),
                .project(target: "DesignSystem", path: "../../DesignSystem")
            ]
        )
    ]
)
