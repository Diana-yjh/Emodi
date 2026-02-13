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
                Text("""
                     Firebase iOS SDK
                     Version: 11.15.0
                     Copyright © Google LLC
                     License: Apache License 2.0
                     https://github.com/firebase/firebase-ios-sdk
                     """
                )
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
