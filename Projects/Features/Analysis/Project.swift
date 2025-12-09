//
//  Project.swift
//  Manifests
//
//  Created by Yejin Hong on 12/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Analysis",
    targets: [
        .target(
            name: "AnalysisDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: .appIdentifier + "AnalysisDomain",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Domain/**"],
            resources: [],
            dependencies: []
        ),
        .target(
            name: "AnalysisData",
            destinations: .iOS,
            product: .framework,
            bundleId: .appIdentifier + "AnalysisData",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Data/**"],
            resources: [],
            dependencies: [
                .target(name: "AnalysisDomain")
            ]
        ),
        .target(
            name: "AnalysisPresentation",
            destinations: Environment.destinations,
            product: .framework,
            bundleId: .appIdentifier + "AnalysisPresentation",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Presentation/**"],
            resources: [],
            dependencies: [
                .target(name: "AnalysisDomain"),
                .project(target: "DesignSystem", path: "../../DesignSystem")
            ]
        )
    ]
)
