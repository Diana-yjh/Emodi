//
//  NavigationBar.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/8/25.
//

import SwiftUI

public enum Theme {
    case light
    case dark
    
    var image: UIImage {
        switch self {
        case .light:
            DesignSystemAsset.menuIcon.image
        case .dark:
            DesignSystemAsset.menuIconBlack.image
        }
    }
}

public struct NavigationBar: View {
    var onMenuTab: () -> Void
    var onAccountTab: () -> Void
    var theme: Theme
    
    public init(theme: Theme, onMenuTab: @escaping () -> Void, onAccountTab: @escaping () -> Void) {
        self.theme = theme
        self.onMenuTab = onMenuTab
        self.onAccountTab = onAccountTab
    }
    
    public var body: some View {
        HStack {
            Button {
                onMenuTab()
            } label: {
                Image(uiImage: theme.image)
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
    NavigationBar(theme: .light, onMenuTab: {}, onAccountTab: {})
}
