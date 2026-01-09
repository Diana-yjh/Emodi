//
//  Project.swift
//  SplashManifests
//
//  Created by Yejin Hong on 12/9/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Splash",
    targets: [
        .target(
            name: "Splash",
            destinations: Environment.destinations,
            product: .framework,
            bundleId: .appIdentifier + "Splash",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Presentation/**"],
            resources: [],
            dependencies: [
                .project(target: "HomeComposition", path: "../../Features/Home"),
                .project(target: "AnalysisComposition", path: "../../Features/Analysis"),
                .project(target: "SettingPresentation", path: "../../Features/Setting"),
                .project(target: "DesignSystem", path: "../../DesignSystem")
            ]
        )
    ]
)
