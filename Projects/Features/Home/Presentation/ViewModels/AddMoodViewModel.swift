//
//  AddMoodViewModel.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/18/25.
//

import SwiftUI
import DesignSystem

class AddMoodViewModel: ObservableObject {
    @Published var selectedMood: MoodType = .none
    @Published var diaryText: String = ""
    @Published var photos: [String] = []
    
    var canSave: Bool {
        selectedMood != .none
    }
    
    func selectMood(_ mood: MoodType) {
        selectedMood = mood
    }
    
    func save() {
        
    }
}
