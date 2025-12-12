//
//  NavigationBar.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/8/25.
//

import SwiftUI

public struct NavigationBar: View {
    var onMenuTab: () -> Void
    var onAccountTab: () -> Void
    
    public init(onMenuTab: @escaping () -> Void, onAccountTab: @escaping () -> Void) {
        self.onMenuTab = onMenuTab
        self.onAccountTab = onAccountTab
    }
    
    public var body: some View {
        HStack {
            Button {
                onMenuTab()
            } label: {
                Image(uiImage: DesignSystemAsset.menuIcon.image)
                    .resizable()
                    .frame(width: 20, height: 15)
            }
            
            Spacer()
            
            Button {
                onAccountTab()
            } label: {
                Image(uiImage: DesignSystemAsset.userIcon.image)
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .padding()
    }
}

#Preview {
    NavigationBar(onMenuTab: {}, onAccountTab: {})
}
