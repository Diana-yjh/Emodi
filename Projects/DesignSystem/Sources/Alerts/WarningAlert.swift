//
//  WarningAlert.swift
//  DesignSystem
//
//  Created by Yejin Hong on 12/18/25.
//

import SwiftUI

public struct WarningAlert: View {
    var title: String
    var onClickOK: () -> Void
    
    public init(title: String, onClickOK: @escaping () -> Void) {
        self.title = title
        self.onClickOK = onClickOK
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
            .padding()
        }
        .frame(height: 180)
        .frame(maxWidth: 300)
    }
}

#Preview {
    WarningAlert(title: "비어있는 기록을 완성해 주세요", onClickOK: {})
}
