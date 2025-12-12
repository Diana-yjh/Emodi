//
//  EmodiCoordinator.swift
//  Coordinator
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import Combine
import HomePresentation
import AnalysisPresentation
import SettingPresentation
import Splash

public enum Screen {
    case home
    case analysis
    case setting
    case splash
}

public final class EmodiCoordinator: ObservableObject {
    @Published public var currentScreen: Screen = .splash
    
    public init() {}
    
    @ViewBuilder
    public func rootView() -> some View {
        switch currentScreen {
        case .home:
            HomeView()
        case .analysis:
            AnalysisView()
        case .setting:
            SettingView()
        case .splash:
            EmptyView()
        }
    }
    
    @ViewBuilder
    public func splashView() -> some View {
        SplashView(onFinished: { [weak self] in
            self?.currentScreen = .home
        })
    }
    
    public func selectTab(_ tab: Screen) {
        self.currentScreen = tab
    }
}
