//
//  EmodiTabView.swift
//  Splash
//
//  Created by Yejin Hong on 12/16/25.
//

import SwiftUI
import HomeComposition
import AnalysisComposition
import SettingComposition

struct EmodiTabView: View {
    @State private var selectedTab: EmodiTab = .home
    @State private var isTabBarHidden: Bool = false
    
    private var homeFactory = HomeFactoryImplement()
    private var analysisFactory = AnalysisFactoryImplement()
    private var settingFactory = SettingFactoryImplement()
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                homeFactory.makeHomeView(isTabBarHidden: $isTabBarHidden)
            case .analysis:
                analysisFactory.makeAnalysisView()
            case .setting:
                settingFactory.makeSettingView()
            }
            
            VStack {
                Spacer()
                
                CustomTabView { tab in
                    selectedTab = tab
                }
                .frame(maxWidth: 320)
                .offset(y: isTabBarHidden ? 120 : 0)
                .animation(.easeInOut(duration: 0.3), value: isTabBarHidden)
            }
            .ignoresSafeArea()
            .allowsHitTesting(!isTabBarHidden)
        }
    }
}

#Preview {
    EmodiTabView()
}
