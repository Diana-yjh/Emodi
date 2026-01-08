//
//  AnalysisViewModel.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI
import AnalysisDomain

public class AnalysisViewModel: ObservableObject {
    @Published var month: Date = Date()
    @Published var days: [Date?] = []
    @Published var selectedDate: Date = Date()
    @Published var daysWithDiary: [String?] = []
    
    private let moodUseCase: MoodUseCaseProtocol
    
    var calendarHeight: CGFloat {
        let rowCount = Int(ceil(Double(days.count) / 7.0))
        
        let rowHeight: CGFloat = 35      // 날짜 버튼 높이
        let rowSpacing: CGFloat = 30     // LazyVGrid spacing
        let headerHeight: CGFloat = 40   // 요일 헤더
        
        return CGFloat(rowCount) * rowHeight
        + CGFloat(rowCount - 1) * rowSpacing
        + headerHeight
    }
    
    public init(moodUseCase: MoodUseCaseProtocol) {
        self.moodUseCase = moodUseCase
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
    
    @MainActor
    func getCalendarMoodData(date: Date) async -> AnalysisResult<[MoodEntity], AnalysisError> {
        let year = date.toInt(in: "yyyy")
        let month = date.toInt(in: "M")
        
        do {
            guard let startAndEnd = Calendar.current.monthStartAndEnd(year: year, month: month) else{
                return .failure(.getMoodDateFailed)
            }
            
            let result = try await moodUseCase.getMonthMood(startTime: startAndEnd.start, endTime: startAndEnd.end)
            
            daysWithDiary = result.map { item in
                item.getTime().toString(in: "dd")
            }
            
            return .success(result)
        } catch {
            return .failure(.getMoodDateFailed)
        }
    }
    
    func resetDaysWithDiary() {
        daysWithDiary = []
    }
}
