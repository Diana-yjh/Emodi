//
//  EmodiTab.swift
//  DesignSystem
//
//  Created by Yejin Hong on 12/10/25.
//

import Foundation

enum EmodiTab: String {
    case home
    case analysis
    case setting
    
    var selectedIcon: String {
        switch self {
        case .home:
            "house.fill"
        case .analysis:
            "newspaper.fill"
        case .setting:
            "gearshape.fill"
        }
    }
    
    var deSelectedIcon: String {
        switch self {
        case .home:
            "house"
        case .analysis:
            "newspaper"
        case .setting:
            "gearshape"
        }
    }
}
