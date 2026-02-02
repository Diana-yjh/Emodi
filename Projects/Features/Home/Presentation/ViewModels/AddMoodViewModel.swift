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
    @Published var isLoadingImages: Bool = false
    @Published var isSavingImages: Bool = false
    
    var canSave: Bool {
        return selectedMood != .none && diaryText != ""
    }
    
    var moodData: Mood?
    
    private let photoUseCase: PhotoUseCaseProtocol
    private let moodUseCase: MoodUseCaseProtocol
    
    public init(photoUseCase: PhotoUseCaseProtocol, moodUseCase: MoodUseCaseProtocol, moodData: Mood? = nil) {
        self.photoUseCase = photoUseCase
        self.moodUseCase = moodUseCase
        self.moodData = moodData
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
        isSavingImages = true
        
        var urls: [String]?
        
        do {
            urls = try await uploadImage(time: moodData?.time ?? Date())
        } catch {
            return .failure(.uploadImageFailed)
        }
        
        let mood = MoodEntity(
            diaryId: moodData?.diaryID,
            time: moodData?.time ?? Date(),
            date: moodData?.date ?? "\(Date().toYear()).\(Date().toMonthDate())",
            mood: selectedMood.index,
            memo: diaryText,
            photoURL: urls
        )
        
        do {
            try await moodUseCase.addMoodDiary(mood: mood)
            isSavingImages = false
            return .success(())
        } catch {
            isSavingImages = false
            return .failure(.addMoodDiaryFailed)
        }
    }
    
    func fetchMoodData() {
        guard let moodData = moodData else { return }
        
        self.selectedMood = MoodType(index: moodData.mood)
        self.diaryText = moodData.memo
        
        let urls = moodData.photoURL ?? []
        
        guard !urls.isEmpty else { return }
        
        isLoadingImages = true
        
        Task { @MainActor in
            do {
                self.selectedImages = try await downloadImages(urls: urls)
            } catch {
                self.selectedImages = []
            }
            
            self.isLoadingImages = false
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
    
    func uploadImage(time: Date) async throws -> [String] {
        var imageData: [Data: String] = [:]
                
        for image in selectedImages {
            let data = try resizeImage(image)
            imageData.updateValue(time.imageGeneratedTime() + ".jpg", forKey: data)
        }
        
        return try await moodUseCase.uploadImage(imageData: imageData)
    }
    
    private func resizeImage(_ image: UIImage, maxDimension: CGFloat = 128) throws -> Data {
        let size = image.size
        let ratio = min(maxDimension / size.width, maxDimension / size.height)
        
        if ratio < 1.0 {
            let newSize = CGSize(width: size.width * ratio , height: size.height * ratio)
            let renderer = UIGraphicsImageRenderer(size: newSize)
            let resized = renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: newSize))
            }
            
            guard let resizedData = resized.jpegData(compressionQuality: 0.6) else {
                throw HomeError.imageCompressFailed
            }
            
            return resizedData
        }
        
        guard let resizedData = image.jpegData(compressionQuality: 0.6) else {
            throw HomeError.imageCompressFailed
        }
        
        return resizedData
    }
    
    private func downloadImages(urls: [String]) async throws -> [UIImage] {
        var images: [UIImage] = []
        
        for urlstr in urls {
            guard let url = URL(string: urlstr) else {
                throw HomeError.imageDownloadFailed
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data) else {
                throw HomeError.imageDecodeFailed
            }
            
            images.append(image)
        }
        
        return images
    }
}
