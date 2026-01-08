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
    @Binding var selectedDate: Date
    @Binding var daysWithDiary: [String?]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .foregroundStyle(.white)
                .shadow(radius: 2)
            
            VStack {
                WeekDayHeaderView()
                    .padding(.bottom)
                DateView(dateValues: $dateValues, selectedDate: $selectedDate, daysWithDiary: $daysWithDiary, isDiaryAvailable: false) { date in
                    self.selectedDate = date
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
                    .foregroundStyle(color(day: day))
            }
        }
        .frame(height: 40)
    }
    
    func color(day: String) -> Color {
        switch day {
        case "토":
            return DesignSystemAsset.lightPrimary.swiftUIColor
        case "일":
            return DesignSystemAsset.primary.swiftUIColor
        default:
            return DesignSystemAsset.gray.swiftUIColor
        }
    }
}

struct DateView: View {
    @Binding var dateValues: [Date?]
    @Binding var selectedDate: Date
    @Binding var daysWithDiary: [String?]
    
    var isDiaryAvailable: Bool
    
    var onDateSelect: (Date) -> Void
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(dateValues, id: \.self) { value in
                if let value = value {
                    dateButton(date: value)
                } else {
                    Text("").hidden()
                }
            }
        }
    }
    
    func dateButton(date: Date) -> some View {
        Button {
            onDateSelect(date)
        } label: {
            VStack {
                Text(date.toString(in: "dd"))
                    .font(date == selectedDate ? DSFont.bold(16) : DSFont.medium(16))
                    .foregroundStyle(date == selectedDate ? DesignSystemAsset.primary.swiftUIColor : .gray)
                
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundStyle(daysWithDiary.contains(date.toString(in: "dd")) ? DesignSystemAsset.primary.swiftUIColor : .clear)
            }
            
        }
        .overlay {
            if date == selectedDate {
                Circle()
                    .foregroundStyle(DesignSystemAsset.primary.swiftUIColor)
                    .frame(width: 45, height: 45)
                    .opacity(0.2)
            }
        }
    }
}
