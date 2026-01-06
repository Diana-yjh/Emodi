//
//  DiaryView.swift
//  HomeData
//
//  Created by Yejin Hong on 12/16/25.
//

import SwiftUI
import DesignSystem

struct DiaryView: View {
    @State var diary: String = ""
    @Binding var showAddDiaryPopup: Bool
    var diaryFinished: (String) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showAddDiaryPopup = false
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                    
                }
                .padding([.horizontal, .top], 24)
                
                Spacer()
            }
            
            Text("Enter your diary")
                .font(DSFont.bold(24))
                .padding([.horizontal, .bottom])
            
            TextEditor(text: $diary)
                .lineLimit(2)
                .padding()
                .frame(height: 200)
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal)
                .shadow(radius: 2)
            
            Button {
                diaryFinished(diary)
                showAddDiaryPopup = false
            } label: {
                Text("Add")
                    .font(DSFont.bold(20))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(DesignSystemAsset.enableButton.swiftUIColor)
                            .shadow(radius: 3)
                    }
            }
            .padding()
        }
        .frame(height: 400)
        .background(
            Image(uiImage: DesignSystemAsset.popupBackground.image)
        )
        .cornerRadius(30)
        .onTapGesture {
            self.endTextEditing()
        }
        .shadow(radius: 3)
    }
}

#Preview {
    DiaryView(diary: "", showAddDiaryPopup: Binding.constant(true)) {_ in}
}
