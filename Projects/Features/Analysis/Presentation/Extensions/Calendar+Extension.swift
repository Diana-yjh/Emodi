//
//  Calendar+Extension.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/8/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

extension Calendar {
    func monthStartAndEnd(year: Int, month: Int) -> (start: Date, end: Date)? {
        var calendar = Calendar.current
        calendar.timeZone = .current
        
        var components = DateComponents(year: year, month: month, day: 1)
        guard let startOfMonth = calendar.date(from: components) else { return nil }
        
        components.month = month + 1
        
        guard let nextMonth = calendar.date(from: components), let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth) else { return nil }
        
        return (startOfMonth, endOfMonth)
    }
}
