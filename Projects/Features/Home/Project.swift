//
//  Project.swift
//  Config
//
//  Created by Yejin Hong on 12/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Home",
    packages: [
        .alamofire,
        .firebase
    ],
    targets: [
        .target(
            name: "HomeDomain",
            destinations: Environment.destinations,
            product: .framework,
            bundleId: .appIdentifier + "HomeDomain",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Domain/**"],
            resources: [],
            dependencies: []
        ),
        .target(
            name: "HomeData",
            destinations: Environment.destinations,
            product: .framework,
            bundleId: .appIdentifier + "HomeData",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Data/**"],
            resources: [],
            dependencies: [
                .target(name: "HomeDomain")
            ]
        ),
        .target(
            name: "HomePresentation",
            destinations: Environment.destinations,
            product: .framework,
            bundleId: .appIdentifier + "HomePresentation",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .default,
            sources: ["Presentation/**"],
            resources: [],
            dependencies: [
                .alamofire,
                .firebaseStorage,
                .firebaseDatabase,
                .target(name: "HomeDomain"),
                .project(target: "DesignSystem", path: "../../DesignSystem")
            ]
        )
    ]
)
