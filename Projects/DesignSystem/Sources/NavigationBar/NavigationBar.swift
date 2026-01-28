//
//  MainNavigationBar.swift
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

public enum ViewMode {
    case show
    case add
    case edit
}

public struct MainNavigationBar: View {
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
                    .hidden()
            }
            
            Spacer()
            
            Button {
                onAccountTab()
            } label: {
                Image(uiImage: DesignSystemAsset.userIcon.image)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .hidden()
            }
        }
        .padding()
    }
}

public struct SubNavigationBar: View {
    var theme: Theme
    var mode: ViewMode
    
    var onBackButtonTab: () -> Void
    var onDeleteButtonTab: () -> Void
    
    public init(theme: Theme, mode: ViewMode, onBackButtonTab: @escaping () -> Void, onDeleteButtonTab: @escaping () -> Void) {
        self.theme = theme
        self.mode = mode
        self.onBackButtonTab = onBackButtonTab
        self.onDeleteButtonTab = onDeleteButtonTab
    }
    
    public var body: some View {
        HStack {
            Button {
                onBackButtonTab()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 10, height: 20)
                    .foregroundStyle(theme == .light ? .white : .black)
            }
            
            Spacer()
            
            if mode == .edit {
                Button {
                    onDeleteButtonTab()
                } label: {
                    Image(uiImage: DesignSystemAsset.deleteIcon.image)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
        }
        .padding()
    }
}

#Preview {
    MainNavigationBar(theme: .dark, onMenuTab: {}, onAccountTab: {})
    SubNavigationBar(theme: .dark, mode: .add, onBackButtonTab: {}, onDeleteButtonTab: {})
}
