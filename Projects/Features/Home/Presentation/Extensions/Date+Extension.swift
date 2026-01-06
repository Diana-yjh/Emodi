//
//  Date+Extension.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/24/25.
//

import SwiftUI

extension Date {
    func toString(in format: String) -> String {
        if self.toMonthDate() == Date().toMonthDate() && self.toYear() == Date().toYear() { return "Today" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = .current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: self)
    }
    
    func toMonthDate() -> String {
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        
        return "\(month).\(day)"
    }
    
    func toYear() -> String {
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: self)
        
        return "\(year)"
    }
    
    func toTime() -> String {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let second = calendar.component(.second, from: self)
        return "\(hour):\(minute):\(second)"
    }
}
