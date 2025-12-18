//
//  ConfirmAlert.swift
//  DesignSystem
//
//  Created by Yejin Hong on 12/18/25.
//

import SwiftUI

public struct ConfirmAlert: View {
    var title: String
    var onClickOK: () -> Void
    var onClickCancel: () -> Void
    
    public init(title: String, onClickOK: @escaping () -> Void, onClickCancel: @escaping () -> Void) {
        self.title = title
        self.onClickOK = onClickOK
        self.onClickCancel = onClickCancel
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .foregroundStyle(.white)
                .shadow(radius: 3)
            
            VStack {
                Text(title)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(DesignSystemFontFamily.GmarketSans.medium.swiftUIFont(size: 22))
                    .multilineTextAlignment(.leading)
                    .padding()
                
                Spacer()
                
                HStack {
                    Button {
                        onClickCancel()
                    } label: {
                        Text("취소")
                            .font(DesignSystemFontFamily.GmarketSans.medium.swiftUIFont(size: 18))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(
                                        .gray
                                    )
                            )
                    }
                    
                    Spacer()
                    
                    Button {
                        onClickOK()
                    } label: {
                        Text("확인")
                            .font(DesignSystemFontFamily.GmarketSans.medium.swiftUIFont(size: 18))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(
                                        DesignSystemAsset.enableButton.swiftUIColor
                                    )
                            )
                    }
                }
            }
            .padding()
        }
        .frame(height: 180)
        .frame(maxWidth: 300)
    }
}

#Preview {
    ConfirmAlert(title: "작성하신 내용을 저장 하시겠습니까?", onClickOK: {}, onClickCancel: {})
}
