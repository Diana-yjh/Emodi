//
//  EmodiAnalysisView.swift
//  AnalysisPresentation
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI
import DesignSystem

struct EmodiAnalysisView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Analytics")
                .font(DSFont.bold(18))
                .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                .padding(.vertical)
                .padding(.leading, 6)
            
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
                
                
            }
        }
    }
}

#Preview {
    EmodiAnalysisView()
}
