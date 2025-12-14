//
//  HomeView.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/5/25.
//

import SwiftUI
import DesignSystem

public struct HomeView: View {
    public init() {}
    
    @State private var opacity: Double = 0
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                NavigationBar(theme: .light, onMenuTab: {}, onAccountTab: {})
                    .frame(height: 30)
                
                Group {
                    Text("Daily Mood")
                        .font(DSFont.bold(30))
                        .foregroundStyle(.white)
                        .padding(.top)
                        .shadow(radius: 5)
                    Text("How are you today?")
                        .font(DSFont.medium(16))
                        .foregroundStyle(.white)
                        .padding(.top, -5)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                
                Spacer()
                
                motionHistoryView
                    .padding(.top)
                    .ignoresSafeArea()
                
            }
        }
        .background(
            Image(uiImage: DesignSystemAsset.background.image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
//        .opacity(opacity)
//        .onAppear {
//            withAnimation {
//                opacity = 1
//            }
//        }
    }
    
    @ViewBuilder
    var motionHistoryView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack {
                DateBar()
                    .padding(.horizontal, 30)
                    .frame(height: 100)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Spacer()
                
                Text("There is no motion diary")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

#Preview {
    HomeView()
}
