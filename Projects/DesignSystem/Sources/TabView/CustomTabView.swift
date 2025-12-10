//
//  CustomTabView.swift
//  DesignSystem
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import Combine

public struct CustomTabView: View {
    @ObservedObject var viewModel: CustomTabViewModel = CustomTabViewModel()
    @Namespace private var tabAnimation
    
    public init() {}
    
    public var body: some View {
        HStack {
            TabIcon(
                tab: .home,
                selected: viewModel.selectedTab == .home,
                namespace: tabAnimation
            ) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    viewModel.selectedTab = .home
                }
            }
            
            Spacer()
            
            TabIcon(
                tab: .analysis,
                selected: viewModel.selectedTab == .analysis,
                namespace: tabAnimation
            ) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    viewModel.selectedTab = .analysis
                }
            }
            
            Spacer()
            
            TabIcon(
                tab: .setting,
                selected: viewModel.selectedTab == .setting,
                namespace: tabAnimation
            ) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    viewModel.selectedTab = .setting
                }
            }
        }
        .padding()
        .background(DesignSystemAsset.menuButton.swiftUIColor)
        .clipShape(Capsule())
        .padding()
        .shadow(radius: 5)
    }
}

struct TabIcon: View {
    var tab: EmodiTab
    var selected: Bool
    var namespace: Namespace.ID
    var onTap: () -> Void
    
    init(tab: EmodiTab, selected: Bool, namespace: Namespace.ID, onTap: @escaping () -> Void) {
        self.tab = tab
        self.selected = selected
        self.namespace = namespace
        self.onTap = onTap
    }
    
    var body: some View {
        ZStack {
            if selected {
                Circle()
                    .fill(Color.white)
                    .frame(width: 60, height: 60)
                    .matchedGeometryEffect(id: "TAB_BACKGROUND", in: namespace)
            }
            
            Image(systemName: selected ? tab.selectedIcon : tab.deSelectedIcon)
                .font(.system(size: selected ? 34 : 28))
                .foregroundStyle(selected ? DesignSystemAsset.menuButton.swiftUIColor : .white)
        }
        .frame(width: 40, height: 40)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}


#Preview {
    CustomTabView()
}
