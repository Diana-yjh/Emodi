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

extension Screen {
    var toEmodiTab: EmodiTab? {
        switch self {
        case .home: return .home
        case .analysis: return .analysis
        case .setting: return .setting
        case .splash: return nil
        }
    }
}

@main
struct EmodiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var coordinator = EmodiCoordinator()
    
    init() {}
    
    var body: some Scene {
        WindowGroup {
            switch coordinator.currentScreen {
            case .splash:
                coordinator.splashView()
            case .home, .analysis, .setting:
                
                ZStack {
                    coordinator.rootView()
                    
                    VStack {
                        Spacer()
                        
                        CustomTabView(
                            onTabSelected: { newTab in
                                switch newTab {
                                case .home:
                                    coordinator.selectTab(.home)
                                case .analysis:
                                    coordinator.selectTab(.analysis)
                                case .setting:
                                    coordinator.selectTab(.setting)
                                }
                            }
                        )
                        .padding(.horizontal, 40)
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
