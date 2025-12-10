//
//  NavigationBar.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/8/25.
//

import SwiftUI
import DesignSystem

struct NavigationBar: View {
    var body: some View {
        HStack {
            Button {
            } label: {
                Image(uiImage: DesignSystemAsset.menuIcon.image)
                    .resizable()
                    .frame(width: 20, height: 15)
            }
            
            Spacer()
            
            Image(uiImage: DesignSystemAsset.userIcon.image)
                .resizable()
                .frame(width: 30, height: 30)
        }
        .padding()
    }
}

#Preview {
    NavigationBar()
}
