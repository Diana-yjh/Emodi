//
//  LibraryInfoView.swift
//  SettingComposition
//
//  Created by Yejin Hong on 1/9/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct LibraryInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .center) {
            SubNavigationBar(theme: .dark, mode: .show, onBackButtonTab: {
                dismiss()
            }, onDeleteButtonTab: {})
            
            ScrollView {
                Text("1. Firebase")
                    .font(DSFont.bold(18))
                    .foregroundStyle(DesignSystemAsset.gray.swiftUIColor)
                    .padding(.horizontal)
                Text("본 애플리케이션은 Google Firebase SDK 및 관련 구성 요소를 사용합니다.\nFirebase SDK는 아래의 Apache License 2.0 조건에 따라 배포됩니다.\nCopyright (c) 2024 Google LLC\nLicensed under the Apache License, Version 2.0")
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
    LibraryInfoView()
}
