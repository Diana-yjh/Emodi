//
//  CalendarView.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI
import DesignSystem

struct EmodiCalendarView: View {
    @Binding var dateValues: [Date?]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .foregroundStyle(.white)
                .shadow(radius: 2)
            
            VStack {
                WeekDayHeaderView()
                    .padding(.bottom)
                DateView(dateValues: $dateValues) {
                    
                }
            }
            .padding()
        }
    }
}

struct WeekDayHeaderView: View {
    private let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
    
    var body: some View {
        HStack {
            ForEach(weekdays, id: \.self) { day in
                Text(day)
                    .font(DSFont.bold(16))
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(day == "일" ? DesignSystemAsset.enableButton.swiftUIColor : DesignSystemAsset.menuButton.swiftUIColor)
            }
        }
    }
}

struct DateView: View {
    @Binding var dateValues: [Date?]
    var isDiaryAvailable: Bool = false
    
    var onDateSelect: () -> Void
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 45) {
            ForEach(dateValues, id: \.self) { value in
                if let value = value {
                    dateButton(date: value.toString(in: "dd"))
                } else {
                    Text("").hidden()
                }
            }
        }
    }
    
    func dateButton(date: String) -> some View {
        Button {
            onDateSelect()
        } label: {
            Text(date)
                .font(DSFont.medium(14))
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    EmodiCalendarView(dateValues: Binding.constant([]))
}
