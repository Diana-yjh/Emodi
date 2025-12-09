//
//  DateBar.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/8/25.
//

import SwiftUI
import DesignSystem

struct DateBar: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                HStack {
                    Text("Today")
                        .font(DSFont.bold(16))
                        .foregroundStyle(.black)
                    Image(uiImage: DesignSystemAsset.chevronDown.image)
                        .resizable()
                        .frame(width: 14, height: 8)
                }
            }
            Spacer()
            Text("2025.12.05")
                .font(DSFont.medium(14))
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    DateBar()
}
