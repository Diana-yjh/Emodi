//
//  Project.swift
//  AnalysisManifests
//
//  Created by Yejin Hong on 12/8/25.
//

import ProjectDescription

let project = Project(
    name: "DesignSystem",
    targets: [
        .target(
            name: "DesignSystem",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.diana.designsystem",
            deploymentTargets: .iOS(
                "17.0"
            ),
            infoPlist: .extendingDefault(
                with: [
                    "UIAppFonts": [
                        "Fonts/GmarketSansBold.otf",
                        "Fonts/GmarketSansMedium.otf",
                        "Fonts/GmarketSansLight.otf"
                    ]
                ]
            ),
            sources: [],
            resources: ["Resources/**"],
            dependencies: []
        )
    ]
    , resourceSynthesizers: [
        .strings(),
        .assets(),
        .fonts()
    ]
)
