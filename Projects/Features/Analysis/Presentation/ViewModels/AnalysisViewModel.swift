//
//  AnalysisViewModel.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI

public class AnalysisViewModel: ObservableObject {
    @Published var month: Date = Date()
    @Published var days: [Date?] = []
    
    var calendarHeight: CGFloat {
        let rowCount = Int(ceil(Double(days.count) / 7.0))
        
        let rowHeight: CGFloat = 35      // 날짜 버튼 높이
        let rowSpacing: CGFloat = 40     // LazyVGrid spacing
        let headerHeight: CGFloat = 30   // 요일 헤더
        let verticalPadding: CGFloat = 0
        
        return CGFloat(rowCount) * rowHeight
        + CGFloat(rowCount - 1) * rowSpacing
        + headerHeight
        + verticalPadding
    }
    
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newValue = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newValue
        }
    }
    
    func extractDays(currentMonth: Date) {
        let calendar = Calendar.current
        
        var days = currentMonth.getAllDays()
        
        // 일요일 1, 월요일 2, 화요일 3
        let firstDayOfWeek = calendar.component(.weekday, from: (days.first ?? Date()) ?? Date())
        
        for _ in 0 ..< firstDayOfWeek - 1 {
            days.insert(nil, at: 0)
        }
        
        self.days = days
    }
}
