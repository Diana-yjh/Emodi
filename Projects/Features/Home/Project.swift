//
//  Project.swift
//  Config
//
//  Created by Yejin Hong on 12/5/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Home",
    targets: [
        // MARK: - HomeDomain
        // Entity, Repository Protocol, UseCase 정의
        // 순수한 비즈니스 로직만 포함 (외부 의존성 없음)
        .makeTarget(
            name: "HomeDomain",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).home.domain",
            sources: ["Domain/**"],
            dependencies: []
        ),
        
        // MARK: - HomeData
        // Repository 구현체, DataSource, Firebase/Network 연동
        // Firebase 의존성은 Core 모듈을 통해 주입받음
        .makeTarget(
            name: "HomeData",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).home.data",
            sources: ["Data/**"],
            dependencies: [
                .target(name: "HomeDomain"),
                // Core 모듈을 통해 Firebase 접근
                .Module.core
            ]
        ),
        
        // MARK: - HomePresentation
        // View, ViewModel
        // UI 관련 코드만 포함
        .makeTarget(
            name: "HomePresentation",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).home.presentation",
            sources: ["Presentation/**"],
            dependencies: [
                .target(name: "HomeDomain"),
                .Module.designSystem
            ]
        ),
        
        // MARK: - HomeComposition
        // 의존성 주입 및 Factory
        // 모든 레이어를 조합
        .makeTarget(
            name: "HomeComposition",
            product: .framework,
            bundleId: "\(Environment.bundleIdPrefix).home.composition",
            sources: ["Composition/**"],
            dependencies: [
                .target(name: "HomeDomain"),
                .target(name: "HomeData"),
                .target(name: "HomePresentation")
            ]
        )
    ]
)
