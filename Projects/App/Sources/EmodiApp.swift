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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var coordinator = EmodiCoordinator()
    
    init() {}
    
    var body: some Scene {
        WindowGroup {
            coordinator.rootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
