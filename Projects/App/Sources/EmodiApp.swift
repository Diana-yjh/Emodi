//
//  App.swift
//  EmodiTest
//
//  Created by Yejin Hong on 12/5/25.
//  Copyright © 2025 diana. All rights reserved.
//

import SwiftUI
import Coordinator

@main
struct EmodiApp: App {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            coordinator.rootView()
        }
    }
}
