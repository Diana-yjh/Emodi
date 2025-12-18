//
//  SplashView.swift
//  Splash
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import HomePresentation
import AnalysisPresentation
import SettingPresentation
import DesignSystem

typealias SplashDestinations = Array<Splashs>

enum Splashs: Hashable {
    case tabView
}

public struct SplashView: View {
    @State private var navigationPath: SplashDestinations = .init()
    @State private var opacity: Double = 1.0
    @State private var splashFinished = false
    
    public init() {}
    
    public var body: some View {
        if splashFinished {
            EmodiTabView()
        } else {
            VStack(alignment: .leading, spacing: 25) {
                Spacer()
                
                Group {
                    Text("하루의 기분을")
                    Text("Emodi 와 함께")
                    Text("기록해보세요")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(DSFont.bold(40))
                .foregroundStyle(.white)
                .padding(.horizontal, 30)
                .shadow(radius: 5)
                
                Spacer()
                Spacer()
                Spacer()
            }
            .ignoresSafeArea()
            .onAppear {
                startFadeOut()
            }
            .background {
                Image(uiImage: DesignSystemAsset.launchScreen.image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            .opacity(opacity)
            .ignoresSafeArea()
            
        }
    }
    
    private func startFadeOut() {
        guard opacity == 1 else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut(duration: 0.5)) {
                opacity = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            splashFinished = true
        }
    }
}

#Preview {
    SplashView()
}
