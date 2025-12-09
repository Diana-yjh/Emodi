//
//  SplashView.swift
//  Splash
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem

public struct SplashView: View {
    private let onFinished: () -> Void
    
    @State private var opacity: Double = 1.0
    
    public init(onFinished: @escaping () -> Void) {
        self.onFinished = onFinished
    }
    
    public var body: some View {
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
            
            Button {
                startFadeOut()
            } label: {
                HStack {
                    Spacer()
                    HStack {
                        Text("시작하기")
                            .font(DSFont.bold(20))
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 23))
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 24)
                    .background(Color.buttonColor(.menu))
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
            .frame(height: 50)
            
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
    
    private func startFadeOut() {
        guard opacity == 1 else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeOut(duration: 0.5)) {
                opacity = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            onFinished()
        }
    }
}

#Preview {
    SplashView(onFinished: {})
}
