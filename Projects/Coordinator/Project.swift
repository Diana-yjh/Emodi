//
//  Project.swift
//  Config
//
//  Created by Yejin Hong on 12/5/25.
//

import ProjectDescription

let project = Project(
    name: "Coordinator",
    targets: [
        .target(
            name: "Coordinator",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.diana.Coordinator",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "HomePresentation", path: "../Features/Home"),
                .project(target: "AnalysisPresentation", path: "../Features/Analysis"),
                .project(target: "SettingPresentation", path: "../Features/Setting"),
                .project(target: "Splash", path: "../Features/Splash")
            ]
        )
    ]
)
