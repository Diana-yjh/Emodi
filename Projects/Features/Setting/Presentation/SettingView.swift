//
//  SettingView.swift
//  SettingData
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem

public struct SettingView: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            VStack(alignment: .center) {
                MainNavigationBar(theme: .dark, onMenuTab: {}, onAccountTab: {})
                    .frame(height: 30)
                
                Text("Settings")
                    .font(DSFont.bold(30))
                    .padding(.top)
                
                SettingSubView(title: "System Settings")
                    .frame(height: 180)
                    .padding()
                
                SettingSubView(title: "Customer Support")
                    .frame(height: 180)
                    .padding()
                
                Text("App version: 1.0.0 Beta")
                    .font(DSFont.medium(14))
                    .foregroundStyle(.gray)
                
                Spacer()
            }
        }
        .background(
            Image(uiImage: DesignSystemAsset.grayBackground.image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}

struct SettingSubView: View {
    var title: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(DSFont.bold(18))
                .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                .padding(.vertical)
                .padding(.leading, 6)
            
            RoundedRectangle(cornerRadius: 22)
                .foregroundStyle(.white)
                .shadow(radius: 2)
        }
    }
}

#Preview {
    SettingView()
}
