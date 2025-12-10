//
//  Dependencies.swift
//  Config
//
//  Created by Yejin Hong on 12/3/25.
//

import ProjectDescription

extension TargetDependency {
    public enum HomeProject {}
    public enum AnalysisProject {}
    public enum SettingProject {}
    public enum Project {}
}

public extension TargetDependency {
    static let alamofire: TargetDependency = .package(product: "Alamofire")
    static let firebaseStorage: TargetDependency = .package(product: "FirebaseStorage")
    static let firebaseDatabase: TargetDependency = .package(product: "FirebaseDatabase")
    static let firebaseCrashlytics: TargetDependency = .package(product: "FirebaseCrashlytics")
    static let firebaseCore: TargetDependency = .package(product: "FirebaseCore")
}

public extension TargetDependency.Project {
    static let ThirdParty = TargetDependency.project(target: "ThirdParty", path: .relativeToRoot("Projects/ThirdParty"))
    static let Coordinator = TargetDependency.project(target: "Coordinator", path: .relativeToRoot("Projects/Coordinator"))
}

public extension TargetDependency.HomeProject {
    static let HomeDomain = TargetDependency.project(target: "HomeDomain", path: .relativeToRoot("Projects/HomeApp/HomeDomain"))
    static let HomeData = TargetDependency.project(target: "HomeData", path: .relativeToRoot("Projects/HomeApp/HomeData"))
    static let HomePresentation = TargetDependency.project(target: "HomePresentation", path: .relativeToRoot("Projects/HomeApp/HomePresentation"))
}

public extension TargetDependency.AnalysisProject {
    static let AnalysisDomain = TargetDependency.project(target: "AnalysisDomain", path: .relativeToRoot("Projects/AnalysisApp/AnalysisDomain"))
    static let AnalysisData = TargetDependency.project(target: "AnalysisData", path: .relativeToRoot("Projects/AnalysisApp/AnalysisData"))
    static let AnalysisPresentation = TargetDependency.project(target: "AnalysisPresentation", path: .relativeToRoot("Projects/AnalysisApp/AnalysisPresentation"))
}

public extension TargetDependency.SettingProject {
    static let SettingDomain = TargetDependency.project(target: "SettingDomain", path: .relativeToRoot("Projects/SettingApp/SettingDomain"))
    
}
public extension Package {
    static let alamofire: Package = .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.2")
    static let firebase: Package = .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.0")
}

public extension SourceFilesList {
    static let sources: SourceFilesList = "Emodi/Sources/**"
    static let tests: SourceFilesList = "Emodi/Tests/**"
}

public enum ResourceType: String {
  case resources = "Resources/**"
}

public extension Array where Element == FileElement {
  static func resources(with resources: [ResourceType]) -> [FileElement] {
    resources.map { FileElement(stringLiteral: $0.rawValue) }
  }
}
