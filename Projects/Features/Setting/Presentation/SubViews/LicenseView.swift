//
//  LicenseView.swift
//  SettingComposition
//
//  Created by Yejin Hong on 1/9/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct LicenseView: View {
    @Environment(\.dismiss) var dismiss
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .center) {
            SubNavigationBar(theme: .dark, mode: .show, onBackButtonTab: {
                dismiss()
            }, onDeleteButtonTab: {})
            
            ScrollView {
                Text("1. License")
                    .font(DSFont.bold(18))
                    .foregroundStyle(DesignSystemAsset.gray.swiftUIColor)
                    .padding(.horizontal)
                Text("Licensed under the Apache License, Version 2.0 (the \"License\");\nyou may not use this file except in compliance with the License.\nYou may obtain a copy of the License at:\nhttp://www.apache.org/licenses/LICENSE-2.0\nUnless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\nSee the License for the specific language governing permissions and limitations under the License.")
                    .font(DSFont.medium(14))
                    .foregroundStyle(DesignSystemAsset.gray.swiftUIColor)
                    .lineSpacing(3)
                    .padding()
                
                Text("2. Apple iOS Frameworks")
                    .font(DSFont.bold(18))
                    .foregroundStyle(DesignSystemAsset.gray.swiftUIColor)
                    .padding(.horizontal)
                Text("Swift, Foundation, SwiftUI 등 기본 제공 프레임워크는 Apple 소프트웨어 라이선스 계약에 따라 제공됩니다.")
                    .font(DSFont.medium(14))
                    .foregroundStyle(DesignSystemAsset.gray.swiftUIColor)
                    .lineSpacing(3)
                    .padding()
            }
            .scrollIndicators(.hidden)
            Spacer()
        }
        .background(
            Image(uiImage: DesignSystemAsset.grayBackground.image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
}

#Preview {
    LicenseView()
}
