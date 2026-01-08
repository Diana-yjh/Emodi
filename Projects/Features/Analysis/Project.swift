//
//  Project.swift
//  Manifests
//
//  Created by Yejin Hong on 12/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Analysis",
    targets: [
        // MARK: - AnalysisDomain
        .makeTarget(
            name: "AnalysisDomain",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).analysis.domain",
            sources: ["Domain/**"],
            dependencies: []
        ),
        
        // MARK: - AnalysisData
        .makeTarget(
            name: "AnalysisData",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).analysis.data",
            sources: ["Data/**"],
            dependencies: [
                .target(name: "AnalysisDomain"),
                .Module.core  // Firebase 필요시 Core를 통해 접근
            ]
        ),
        
        // MARK: - AnalysisPresentation
        .makeTarget(
            name: "AnalysisPresentation",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).analysis.presentation",
            sources: ["Presentation/**"],
            dependencies: [
                .target(name: "AnalysisDomain"),
                .Module.designSystem
            ]
        ),
        
        .makeTarget(
            name: "AnalysisComposition",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).analysis.composition",
            sources: ["Composition/**"],
            dependencies: [
                .target(name: "AnalysisDomain"),
                .target(name: "AnalysisData"),
                .target(name: "AnalysisPresentation")
            ]
        )
    ]
)
