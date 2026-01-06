//
//  Dependencies.swift
//  Config
//
//  Created by Yejin Hong on 12/3/25.
//

import ProjectDescription

// MARK: - External Package Dependencies
public extension TargetDependency {
    // Alamofire
    static let alamofire: TargetDependency = .package(product: "Alamofire")
    
    // Firebase - 각 모듈별로 필요한 것만 사용
    static let firebaseAuth: TargetDependency = .package(product: "FirebaseAuth")
    static let firebaseFirestore: TargetDependency = .package(product: "FirebaseFirestore")
    static let firebaseStorage: TargetDependency = .package(product: "FirebaseStorage")
    static let firebaseDatabase: TargetDependency = .package(product: "FirebaseDatabase")
}

public extension Package {
    static let alamofire: Package = .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.2")
    static let firebase: Package = .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "11.0.0"))
}

// MARK: - Internal Module Dependencies
public extension TargetDependency {
    enum Module {
        // Core modules
        public static let core: TargetDependency = .project(
            target: "Core",
            path: .relativeToRoot("Projects/Core")
        )
        
        // DesignSystem
        public static let designSystem: TargetDependency = .project(
            target: "DesignSystem",
            path: .relativeToRoot("Projects/DesignSystem")
        )
    }
    
    enum Home {
        public static let domain: TargetDependency = .project(
            target: "HomeDomain",
            path: .relativeToRoot("Projects/Features/Home")
        )
        public static let data: TargetDependency = .project(
            target: "HomeData",
            path: .relativeToRoot("Projects/Features/Home")
        )
        public static let presentation: TargetDependency = .project(
            target: "HomePresentation",
            path: .relativeToRoot("Projects/Features/Home")
        )
        public static let composition: TargetDependency = .project(
            target: "HomeComposition",
            path: .relativeToRoot("Projects/Features/Home")
        )
    }
    
    enum Analysis {
        public static let domain: TargetDependency = .project(
            target: "AnalysisDomain",
            path: .relativeToRoot("Projects/Features/Analysis")
        )
        public static let data: TargetDependency = .project(
            target: "AnalysisData",
            path: .relativeToRoot("Projects/Features/Analysis")
        )
        public static let presentation: TargetDependency = .project(
            target: "AnalysisPresentation",
            path: .relativeToRoot("Projects/Features/Analysis")
        )
    }
    
    enum Setting {
        public static let domain: TargetDependency = .project(
            target: "SettingDomain",
            path: .relativeToRoot("Projects/Features/Setting")
        )
        public static let data: TargetDependency = .project(
            target: "SettingData",
            path: .relativeToRoot("Projects/Features/Setting")
        )
        public static let presentation: TargetDependency = .project(
            target: "SettingPresentation",
            path: .relativeToRoot("Projects/Features/Setting")
        )
    }
    
    enum Splash {
        public static let splash: TargetDependency = .project(
            target: "Splash",
            path: .relativeToRoot("Projects/Features/Splash")
        )
    }
}

// MARK: - Source Files & Resources
public extension SourceFilesList {
    static let sources: SourceFilesList = "Sources/**"
    static let tests: SourceFilesList = "Tests/**"
}

public enum ResourceType: String {
    case resources = "Resources/**"
}

public extension Array where Element == FileElement {
    static func resources(with resources: [ResourceType]) -> [FileElement] {
        resources.map { FileElement(stringLiteral: $0.rawValue) }
    }
}
