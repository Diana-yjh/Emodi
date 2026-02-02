//
//  HomeViewModel.swift
//  HomeDomain
//
//  Created by Yejin Hong on 1/6/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI
import HomeDomain

public class HomeViewModel: ObservableObject {
    @Published var selectedDate: String = "\(Date().toYear()).\(Date().toMonthDate())"
    @Published var moodList: [Mood] = []
    @Published var showAddMoodAlert: Bool = false
    
    private let moodUseCase: MoodUseCaseProtocol
    
    public init(moodUseCase: MoodUseCaseProtocol) {
        self.moodUseCase = moodUseCase
    }
    
    @MainActor
    func fetchMoodLists() async {
        var result: [FetchMoodEntity?] = []
        
        do {
            result = try await moodUseCase.fetchMoodDiary(date: selectedDate)
        } catch {
            print("Error")
        }
        
        result.forEach { item in
            if let item = item {
                let newMood = Mood(diaryID: item.diaryID, memo: item.memo, mood: item.mood, time: item.time, date: item.date, photoURL: item.photoURL)
                
                if !moodList.contains(newMood) {
                    moodList.insert(Mood(diaryID: item.diaryID, memo: item.memo, mood: item.mood, time: item.time, date: item.date, photoURL: item.photoURL), at: 0)
                }
            }
        }
    }
    
    func clearMoodList() {
        withAnimation(.easeInOut(duration: 0.3)) {
            moodList.removeAll()
        }
    }
}
