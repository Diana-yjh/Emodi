//
//  App.swift
//  EmodiTest
//
//  Created by Yejin Hong on 12/5/25.
//  Copyright © 2025 diana. All rights reserved.
//

import SwiftUI
import Splash
import FirebaseCore
import FirebaseFirestore

@main
struct EmodiApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
