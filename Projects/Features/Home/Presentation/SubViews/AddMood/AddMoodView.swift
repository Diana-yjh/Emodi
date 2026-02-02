//
//  AddMoodView.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem
import PhotosUI

enum AddMoodViewText {
    case saveButton
    case editButton
    
    var title: String {
        switch self {
        case .saveButton:
            "저장하기"
        case .editButton:
            "수정하기"
        }
    }
}

struct AddMoodView: View {
    @StateObject private var viewModel: AddMoodViewModel
    @State private var showAddDiaryPopup = false
    @State private var showSavePopup = false
    @State private var showSaveWarningPopup = false
    @State private var showSaveFailedPopup = false
    @State private var showMoodDeleteAlert: Bool = false
    @State private var saveTrigger = false
    
    @Environment(\.dismiss) private var dismiss
    
    init(factory: HomeFactory, date: Date, moodData: Mood?) {
        _viewModel = StateObject(wrappedValue: factory.makeAddMoodViewModel(date: date, moodData: moodData))
    }
    
    var isEditMode: Bool {
        viewModel.moodData != nil
    }
    
    var body: some View {
        VStack {
            navigationBar
            scrollContent
            saveButton
        }
        .navigationBarHidden(true)
        .background { backgroundImage }
        .onAppear { viewModel.fetchMoodData() }
        .overlay { alertOverlays }
        .overlay { savingOverlay }
        .task(id: saveTrigger, saveTask)
    }
    
    private var navigationBar: some View {
        SubNavigationBar(
            theme: .dark,
            mode: isEditMode ? .edit : .add,
            onBackButtonTab: { dismiss() },
            onDeleteButtonTab: { showMoodDeleteAlert = true }
        )
    }
    
    private var scrollContent: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("오늘 기분은 어떠세요?")
                    .font(DSFont.bold(26))
                
                moodSection
                diarySection
                photoSection
                
                Spacer()
            }
        }
    }
    
    private var moodSection: some View {
        MoodSectionView(selected: viewModel.selectedMood) { mood in
            viewModel.selectMood(mood)
        }
        .padding()
    }
    
    private var diarySection: some View {
        VStack {
            HStack {
                Image(systemName: SectionType.diary.icon)
                    .resizable()
                    .frame(width: 22, height: 18)
                
                Text(SectionType.diary.title)
                    .font(DSFont.bold(16))
                    .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                
                Spacer()
            }
            .padding(.vertical, 12)
            
            VStack(alignment: .leading) {
                Text(viewModel.diaryText)
                    .font(DSFont.medium(16))
                    .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
                    .lineSpacing(5)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
            }
        }
        .padding()
        .onTapGesture { showAddDiaryPopup = true }
    }
    
    private var photoSection: some View {
        VStack {
            HStack {
                Image(systemName: SectionType.photo.icon)
                    .resizable()
                    .frame(width: 24, height: 18)
                
                Text(SectionType.photo.title)
                    .font(DSFont.bold(16))
                
                Spacer()
            }
            .padding(.vertical, 12)
            
            VStack {
                Spacer()
                
                if viewModel.isLoadingImages {
                    ProgressView()
                        .scaleEffect(1.5)
                } else if !viewModel.selectedImages.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.selectedImages, id: \.self) { image in
                                ImageCell(onDeleteTap: {
                                    viewModel.selectedImages.remove(image)
                                }, uiImage: image)
                            }
                        }
                    }
                }
                
                if !viewModel.isLoadingImages && viewModel.selectedImages.count < 5 {
                    PhotosPicker(selection: $viewModel.imageSelections, maxSelectionCount: 5, matching: .images) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 26, height: 26)
                            .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 180)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
            }
        }
        .padding(.horizontal)
    }
    
    private var saveButton: some View {
        EmodiButton(title: isEditMode ? AddMoodViewText.editButton.title : AddMoodViewText.saveButton.title) {
            if viewModel.canSave {
                showSavePopup = true
            } else {
                showSaveWarningPopup = true
            }
        }
        .padding()
    }
    
    private var backgroundImage: some View {
        Image(uiImage: DesignSystemAsset.grayBackground.image)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    private var savingOverlay: some View {
        Group {
            if viewModel.isSavingImages {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .scaleEffect(2)
                        .tint(.white)
                }
                .allowsHitTesting(true)
            }
        }
    }
    
    @ViewBuilder
    private var alertOverlays: some View {
        if showAddDiaryPopup {
            diaryPopupOverlay
        } else if showSavePopup {
            savePopupOverlay
        } else if showSaveWarningPopup {
            saveWarningOverlay
        } else if showSaveFailedPopup {
            saveFailedOverlay
        } else if viewModel.showPhotoPermissionAlert {
            photoPermissionOverlay
        } else if showMoodDeleteAlert {
            deleteAlertOverlay
        }
    }
    
    private var diaryPopupOverlay: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { showAddDiaryPopup = false }
            
            DiaryView(showAddDiaryPopup: $showAddDiaryPopup) { content in
                viewModel.diaryText = content
            }
            .padding()
        }
    }
    
    private var savePopupOverlay: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) { showSavePopup = false }
                }
            
            ConfirmAlert(title: "작성한 내용을 저장 하시겠습니까?") {
                saveTrigger = true
            } onClickCancel: {
                showSavePopup = false
            }
            .padding()
        }
    }
    
    private var saveWarningOverlay: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) { showSaveWarningPopup = false }
                }
            
            WarningAlert(title: "비어있는 기록을 완성해 주세요") {
                showSaveWarningPopup = false
            }
            .padding()
        }
    }
    
    private var saveFailedOverlay: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) { showSaveFailedPopup = false }
                }
            
            WarningAlert(title: "기록 저장에 실패하였습니다") {
                showSaveFailedPopup = false
                dismiss()
            }
            .padding()
        }
    }
    
    private var photoPermissionOverlay: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) { viewModel.showPhotoPermissionAlert = false }
                }
            
            WarningAlert(title: "사진을 추가하기 위해서 권한을 허용해주세요") {
                viewModel.openPhotoSettings()
                viewModel.showPhotoPermissionAlert = false
            }
            .padding()
        }
    }
    
    private var deleteAlertOverlay: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) { showMoodDeleteAlert = false }
                }
            
            ConfirmAlert(title: "기록을 삭제하시겠습니까?", onClickOK: {
                Task {
                    let result = await viewModel.deleteMoodData(diaryId: viewModel.moodData?.diaryID ?? "")
                    switch result {
                    case .success():
                        showMoodDeleteAlert = false
                        dismiss()
                    case .failure(_):
                        showSaveFailedPopup = true
                    }
                }
            }, onClickCancel: {
                showMoodDeleteAlert = false
            })
            .padding()
        }
    }
    
    @Sendable
    private func saveTask() async {
        guard saveTrigger else { return }
        
        showSavePopup = false
        
        let result = await viewModel.saveMoodData()
        
        switch result {
        case .success(_):
            dismiss()
        case .failure(_):
            showSaveFailedPopup = true
        }
    }
}

struct MoodSectionView: View {
    let moods: [MoodType] = [.best, .good, .normal, .bad, .worst]
    let selected: MoodType?
    let onSelect: (MoodType) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(moods, id: \.self) { mood in
                Spacer()
                Button {
                    withAnimation(.linear(duration: 0.2)) {
                        onSelect(mood)
                    }
                } label: {
                    Image(uiImage: mood.image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .opacity(selected == mood ? 1.0 : 0.3)
                }
            }
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
                .shadow(radius: 2)
        }
    }
}
