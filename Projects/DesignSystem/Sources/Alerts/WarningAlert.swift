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
                    .font(DesignSystemFontFamily.GmarketSans.medium.swiftUIFont(size: 20))
                    .multilineTextAlignment(.leading)
                    .padding()
                
                Spacer()
                
                EmodiButton(title: "확인") {
                    onClickOK()
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
