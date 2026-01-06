//
//  EmodiTabView.swift
//  Splash
//
//  Created by Yejin Hong on 12/16/25.
//

import SwiftUI
import HomeComposition
import AnalysisPresentation
import SettingPresentation

struct EmodiTabView: View {
    @State private var selectedTab: EmodiTab = .home
    @State private var isTabBarHidden: Bool = false
    
    private var homeFactory = HomeFactoryImplement()
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                homeFactory.makeHomeView(isTabBarHidden: Binding.constant(false))
            case .analysis:
                AnalysisView()
            case .setting:
                SettingView()
            }
            
            VStack {
                Spacer()
                
                CustomTabView { tab in
                    selectedTab = tab
                }
                .frame(maxWidth: 320)
            }
            .ignoresSafeArea()
            .opacity(isTabBarHidden ? 0 : 1)
            .allowsHitTesting(isTabBarHidden == false)
        }
    }
}

#Preview {
    EmodiTabView()
}
