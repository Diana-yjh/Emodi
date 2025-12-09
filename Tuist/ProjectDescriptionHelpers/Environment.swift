//
//  Environment.swift
//  Config
//
//  Created by Yejin Hong on 12/3/25.
//

import ProjectDescription

extension String {
    public static let organizationName = "diana"
    public static let appIdentifier = "com.diana."
}

public enum Environment {
    public static let appName = "Emodi"
    public static let appIdentifier = "com.diana"
    public static let deploymentTarget = "17.0"
    public static let destinations: Destinations = .iOS
}
