//
//  Environment.swift
//  Config
//
//  Created by Yejin Hong on 12/3/25.
//

import ProjectDescription

// MARK: - Environment Constants
public enum Environment {
    public static let appName = "Emodi"
    public static let organizationName = "diana"
    public static let bundleIdPrefix = "com.diana"
    public static let deploymentTarget = DeploymentTargets.iOS("17.0")
    public static let destinations: Destinations = .iOS
}

// MARK: - Bundle ID Helpers
public extension String {
    static let organizationName = Environment.organizationName
    static let appIdentifier = Environment.bundleIdPrefix + "."
}

// MARK: - Project Helper
public extension Project {
    static func makeModule(
        name: String,
        organizationName: String = Environment.organizationName,
        packages: [Package] = [],
        targets: [Target],
        resourceSynthesizers: [ResourceSynthesizer] = []
    ) -> Project {
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            targets: targets,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}

// MARK: - Target Helper
public extension Target {
    static func makeTarget(
        name: String,
        product: Product,
        bundleId: String,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        infoPlist: InfoPlist = .default
    ) -> Target {
        return .target(
            name: name,
            destinations: Environment.destinations,
            product: product,
            bundleId: bundleId,
            deploymentTargets: Environment.deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies
        )
    }
}
