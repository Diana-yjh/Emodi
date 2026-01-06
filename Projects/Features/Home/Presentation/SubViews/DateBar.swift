//
//  DateBar.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/8/25.
//

import SwiftUI
import DesignSystem

struct DateBar: View {
    @State private var showDatePicker: Bool = false
    @Binding var date: Date
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Button {
                } label: {
                    HStack {
                        Text(date.toString(in: "MM.dd"))
                            .font(DSFont.bold(16))
                            .foregroundStyle(.black)
                        Image(uiImage: DesignSystemAsset.chevronDown.image)
                            .resizable()
                            .frame(width: 14, height: 8)
                            .padding()
                    }
                }
                .allowsHitTesting(false)
                
                DatePicker(
                    "",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                .accentColor(DesignSystemAsset.enableButton.swiftUIColor)
                .colorMultiply(.clear)
                
            }
            
            Spacer()
            
            Text(date.toYear())
                .font(DSFont.medium(14))
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
//    DateBar(date: Binding.constant(.now))
}
