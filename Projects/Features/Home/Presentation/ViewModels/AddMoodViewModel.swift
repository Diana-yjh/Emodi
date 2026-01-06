//
//  AddMoodViewModel.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/18/25.
//

import SwiftUI
import DesignSystem
import HomeDomain
import PhotosUI

public class AddMoodViewModel: ObservableObject {
    @Published var selectedMood: MoodType = .none
    @Published var diaryText: String = ""
    
    @Published var showPhotoPermissionAlert: Bool = false
    @Published var showImagePicker: Bool = false
    
    @Published var selectedDate: Date = .now
    
    @Published var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            setImage(from: imageSelections)
        }
    }
    
    private func setImage(from selections: [PhotosPickerItem]?) {
        guard let selections else { return }
        
        Task { @MainActor in
            var images: [UIImage] = []
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        images.append(uiImage)
                    }
                }
            }
            selectedImages = images
        }
    }
    
    private let photoUseCase: PhotoUseCaseProtocol
    private let moodUseCase: MoodUseCaseProtocol
    
    public init(photoUseCase: PhotoUseCaseProtocol, moodUseCase: MoodUseCaseProtocol) {
        self.photoUseCase = photoUseCase
        self.moodUseCase = moodUseCase
    }
    
    var canSave: Bool {
        return selectedMood != .none && diaryText != ""
    }
}

extension AddMoodViewModel {
    func selectMood(_ mood: MoodType) {
        selectedMood = mood
    }
    
    func requestPhotoAuthorization() {
        let status = photoUseCase.requestAccess()
        
        switch status {
        case .authorized, .limited:
            showImagePicker = true
            
        case .denied, .notDetermined:
            showPhotoPermissionAlert = true
        }
    }
    
    func openPhotoSettings() {
        photoUseCase.openSettings()
    }
    
    func saveMoodData() async -> EmodiResult<Void, EmodiError> {
        let mood = MoodEntity(
            date: "\(selectedDate.toYear()).\(selectedDate.toMonthDate())",
            time: selectedDate.toTime(),
            mood: selectedMood.index,
            memo: diaryText,
            photoURL: ""
        )
        
        do {
            try await moodUseCase.addMoodDiary(mood: mood)
            return .success(())
        } catch {
            print("FireStore Error: ", error)
            return .failure(.addMoodDiaryFailed)
        }
    }
    
//    func deleteMoodData() async -> EmodiResult<Void, EmodiError> {
//        do {
//            try await moodUseCase.deleteMoodDiary(date: "\(selectedDate.toYear()).\(selectedDate.toMonthDate())", userID: 1, diaryID: 1)
//            return .success(())
//        } catch {
//            return .failure(.deleteMoodDiaryFailed)
//        }
//    }
}
