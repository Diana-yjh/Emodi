//
//  App.swift
//  EmodiTest
//
//  Created by Yejin Hong on 12/5/25.
//  Copyright © 2025 diana. All rights reserved.
//

import SwiftUI
import Coordinator
import FirebaseCore

@main
struct EmodiApp: App {
    @StateObject private var coordinator = AppCoordinator()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.rootView()
        }
    }
}
