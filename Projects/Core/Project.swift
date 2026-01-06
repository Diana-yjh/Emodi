//
//  Project.swift
//  AnalysisManifests
//
//  Created by Yejin Hong on 1/5/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Core",
    packages: [
        .firebase,
        .alamofire
    ],
    targets: [
        // MARK: - Core (Firebase, Network 래핑)
        .makeTarget(
            name: "Core",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).core",
            sources: ["Sources/**"],
            dependencies: [
                .firebaseFirestore,
                .firebaseAuth,
                .firebaseStorage,
                .firebaseDatabase
            ]
        )
    ]
)
