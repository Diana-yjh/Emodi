//
//  AnalysisView.swift
//  AnalysisData
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem

public struct AnalysisView: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            VStack {
                NavigationBar(onMenuTab: {}, onAccountTab: {})
                    .frame(height: 30)
                
                ScrollView {
                    ChangeMonthView(onTabBeforeButton: {}, onTabAfterButton: {})
                        .frame(width: 200)
                    
                    EmodiCalendarView()
                        .frame(height: 400)
                        .padding()
                    
                    EmodiAnalysisView()
                        .frame(height: 220)
                        .padding()
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background {
            Image(uiImage: DesignSystemAsset.analysisBackground.image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

struct ChangeMonthView: View {
    var onTabBeforeButton: () -> Void
    var onTabAfterButton: () -> Void
    
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "chevron.left.circle")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Text("July")
                .font(DSFont.bold(26))
                .foregroundStyle(.white)
                .frame(height: 40)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "chevron.right.circle")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.white)
            }
        }
        .shadow(radius: 5)
    }
}

struct EmodiCalendarView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .foregroundStyle(.white)
                .shadow(radius: 4)
        }
    }
}

struct EmodiAnalysisView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Analytics")
                .font(DSFont.bold(18))
                .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                .padding(.vertical)
                .padding(.leading, 6)
            
            RoundedRectangle(cornerRadius: 22)
                .foregroundStyle(.white)
                .shadow(radius: 4)
        }
    }
}

#Preview {
    AnalysisView()
}
