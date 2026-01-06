//
//  EmodiButton.swift
//  DesignSystem
//
//  Created by Yejin Hong on 12/24/25.
//

import SwiftUI

public struct EmodiButton: View {
    var title: String
    var onButtonTap: () -> Void
    
    public init(title: String, onButtonTap: @escaping () -> Void) {
        self.title = title
        self.onButtonTap = onButtonTap
    }
    
    public var body: some View {
        Button {
            onButtonTap()
        } label: {
            Text(title)
                .font(DesignSystemFontFamily.GmarketSans.bold.swiftUIFont(size: 20))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(DesignSystemAsset.enableButton.swiftUIColor)
                        .shadow(radius: 3)
                }
        }
    }
}

#Preview {
    EmodiButton(title: "저장하기", onButtonTap: {})
}
