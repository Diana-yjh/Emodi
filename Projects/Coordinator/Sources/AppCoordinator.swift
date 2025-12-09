//
//  AppCoordinator.swift
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

public final class AppCoordinator: ObservableObject {
    @Published public var currentScreen: Screen = .splash
    
    public init() {}
    
    @ViewBuilder
    public func rootView() -> some View {
        switch currentScreen {
        case .home:
            withAnimation {
                HomeView()
            }
        case .analysis:
            AnalysisView()
        case .setting:
            SettingView()
        case .splash:
            SplashView(onFinished: { [weak self] in
                self?.currentScreen = .home
            })
        }
    }
}
