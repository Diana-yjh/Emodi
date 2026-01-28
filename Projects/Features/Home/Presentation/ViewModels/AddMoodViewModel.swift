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
    
    var moodData: Mood?
    
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
    
    public init(photoUseCase: PhotoUseCaseProtocol, moodUseCase: MoodUseCaseProtocol, moodData: Mood? = nil) {
        self.photoUseCase = photoUseCase
        self.moodUseCase = moodUseCase
        self.moodData = moodData
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
    
    @discardableResult
    func saveMoodData() async -> HomeResult<Void, HomeError> {
        let mood = MoodEntity(
            diaryId: moodData?.diaryID,
            time: moodData?.time ?? Date(),
            date: moodData?.date ?? "\(Date().toYear()).\(Date().toMonthDate())",
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
    
    func fetchMoodData() {
        if let moodData = moodData {
            self.selectedMood = MoodType(index: moodData.mood)
            self.diaryText = moodData.memo
        }
    }
    
    @discardableResult
    func deleteMoodData(diaryId: String) async -> HomeResult<Void, HomeError> {
        do {
            try await moodUseCase.deleteMoodDiary(diaryId: diaryId)
            return .success(())
        } catch {
            return .failure(.deleteMoodDiaryFailed)
        }
    }
}
