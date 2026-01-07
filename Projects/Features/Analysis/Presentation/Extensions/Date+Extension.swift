//
//  Date+Extension.swift
//  AnalysisPresentation
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

extension Date {
    func toString(in format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter.string(from: self)
    }
    
    func getAllDays() -> [Date?] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            calendar.date(byAdding: .day, value: day - 1, to: startDate) ?? Date()
        }
    }
}
