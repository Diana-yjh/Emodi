//
//  CustomTabView.swift
//  DesignSystem
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import Combine

public struct CustomTabView: View {
    public init() {}
    public var body: some View {
        HStack {
            Image(systemName: "house.fill")
                .font(.system(size: 28))
                .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                .padding(10)
                .background(.white, in: Circle())
            Spacer()
            Image(systemName: "calendar")
                .font(.system(size: 28))
                .foregroundStyle(.white)
                .padding()
//                .background(.white, in: Circle())
            Spacer()
            Image(systemName: "gear")
                .font(.system(size: 28))
                .foregroundStyle(.white)
                .padding()
//                .background(.white, in: Circle())
        }
        .padding(.horizontal, 10)
        .background(DesignSystemAsset.menuButton.swiftUIColor)
        .clipShape(Capsule())
        .padding()
        .shadow(radius: 5)
    }
}

#Preview {
    CustomTabView()
}
