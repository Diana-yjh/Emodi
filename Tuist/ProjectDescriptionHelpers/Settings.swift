//
//  Settings.swift
//  Config
//
//  Created by Yejin Hong on 12/5/25.
//

import ProjectDescription

extension Settings {
    public static var projectAllSettings: Settings {
        .settings(configurations: [
            .release(name: "AppStore"),
            .debug(name: "Debug")
        ],
                  defaultSettings: .recommended
        )
    }
}
