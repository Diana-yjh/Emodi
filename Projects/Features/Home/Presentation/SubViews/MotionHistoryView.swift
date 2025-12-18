//
//  MotionHistoryView.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/14/25.
//

import SwiftUI
import DesignSystem

struct MotionHistoryView: View {
    var historyList: [String] = []
    var onAddButtonTap: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    onAddButtonTap()
                } label: {
                    Image(uiImage: DesignSystemAsset.plusButton.image)
                        .frame(width: 30, height: 30)
                        .padding(.horizontal)
                }
                
                ZStack {
                    Image(uiImage: DesignSystemAsset.bubble.image)
                        .resizable()
                        .frame(width: 260, height: 100)
                        .padding([.top, .trailing], 10)
                    
                    Text("Add new mood diary!")
                        .font(DSFont.bold(14))
                        .foregroundStyle(.white)
                        .padding(.trailing, 24)
                        .padding(.bottom, 4)
                }
                
                Spacer()
            }
            
            ScrollView {
                MoodCellView(moodTitle: "Add your mood", memo: "And your memo")
            }
            .padding(.top, -40)
        }
    }
}

struct MoodCellView: View {
    var moodTitle: String
    var memo: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            Image(uiImage: DesignSystemAsset.timeLine.image)
                .frame(width: 30)
                .padding(.horizontal)
            
            Image(uiImage: DesignSystemAsset.defaultFace.image)
                .frame(width: 50, height: 24)
            
            VStack(alignment: .leading) {
                Text(moodTitle)
                    .font(DSFont.bold(16))
                    .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                
                Text(memo)
                    .font(DSFont.medium(12))
                    .foregroundStyle(DesignSystemAsset.disableButton.swiftUIColor)
                    .padding(.horizontal)
            }
            .frame(height: 24)
            Spacer()
        }
        .frame(height: 100)
    }
}

#Preview {
    MotionHistoryView(onAddButtonTap: {})
}
