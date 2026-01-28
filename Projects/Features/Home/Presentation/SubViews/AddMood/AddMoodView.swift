//
//  AddMoodView.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem
import PhotosUI

struct AddMoodView: View {
    @StateObject private var viewModel: AddMoodViewModel
    @State private var showAddDiaryPopup = false
    @State private var showSavePopup = false
    @State private var showSaveWarningPopup = false
    @State private var showSaveFailedPopup = false
    @State private var showMoodDeleteAlert: Bool = false
    @State private var saveTrigger = false
    
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: AddMoodViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var isEditMode: Bool {
        viewModel.moodData != nil
    }
    
    var body: some View {
        VStack {
            SubNavigationBar(
                theme: .dark,
                mode: isEditMode ? .edit : .add ,
                onBackButtonTab: {
                    dismiss()
                },
                onDeleteButtonTab: {
                showMoodDeleteAlert = true
            })
            
            ScrollView {
                VStack {
                    Text("오늘 기분은 어떠세요?")
                        .font(DSFont.bold(26))
                    
                    MoodSectionView(selected: viewModel.selectedMood) { mood in
                        viewModel.selectMood(mood)
                    }
                    .padding()
                    
                    diarySectionView()
                        .padding()
                        .onTapGesture {
                            showAddDiaryPopup = true
                        }
                    
                    photoSectionView()
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
            
            EmodiButton(title: isEditMode ? "수정하기" : "저장하기") {
                if viewModel.canSave {
                    showSavePopup = true
                } else {
                    showSaveWarningPopup = true
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .background {
            Image(uiImage: DesignSystemAsset.grayBackground.image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .onAppear {
            viewModel.fetchMoodData()
        }
        .overlay {
            if showAddDiaryPopup {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showAddDiaryPopup = false
                        }
                    
                    DiaryView(showAddDiaryPopup: $showAddDiaryPopup) { content in
                        viewModel.diaryText = content
                    }
                    .padding()
                }
            }
            
            if showSavePopup {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.1)) {
                                showSavePopup = false
                            }
                        }
                    
                    ConfirmAlert(title: "작성한 내용을 저장 하시겠습니까?") {
                        saveTrigger = true
                    } onClickCancel: {
                        showSavePopup = false
                    }
                    .padding()
                }
            }
            
            if showSaveWarningPopup {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.1)) {
                                showSaveWarningPopup = false
                            }
                        }
                    
                    WarningAlert(title: "비어있는 기록을 완성해 주세요", onClickOK: {
                        showSaveWarningPopup = false
                    })
                    .padding()
                }
            }
            
            if showSaveFailedPopup {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.1)) {
                                showSaveWarningPopup = false
                            }
                        }
                    
                    WarningAlert(title: "기록 저장에 실패하였습니다", onClickOK: {
                        showSaveFailedPopup = false
                        dismiss()
                    })
                    .padding()
                }
            }
            
            if viewModel.showPhotoPermissionAlert {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.1)) {
                                self.viewModel.showPhotoPermissionAlert = false
                            }
                        }
                    
                    WarningAlert(title: "사진을 추가하기 위해서 권한을 허용해주세요", onClickOK: {
                        self.viewModel.openPhotoSettings()
                        self.viewModel.showPhotoPermissionAlert = false
                    })
                    .padding()
                }
            }
            
            if showMoodDeleteAlert {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.1)) {
                                showSaveWarningPopup = false
                            }
                        }
                    
                    ConfirmAlert(title: "기록을 삭제하시겠습니까?", onClickOK: {
                        Task {
                            let result = await viewModel.deleteMoodData(diaryId: viewModel.moodData?.diaryID ?? "")
                            
                            switch result {
                            case .success():
                                showMoodDeleteAlert = false
                                dismiss()
                            case .failure(let error):
                                showSaveFailedPopup = true
                            }
                        }
                    }, onClickCancel: {
                        showMoodDeleteAlert = false
                    })
                    .padding()
                }
            }
        }
        .task(id: saveTrigger) {
            guard saveTrigger else { return }
            
            let result = await viewModel.saveMoodData()
            
            switch result {
            case .success(_):
                showSavePopup = false
                dismiss()
            case .failure(_):
                showSavePopup = false
                showSaveFailedPopup = true
            }
        }
    }
    
    private func diarySectionView() -> some View {
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
    }
    
    private func photoSectionView() -> some View {
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
                
                if !viewModel.selectedImages.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.selectedImages, id: \.self) { images in
                                ImageCell(onDeleteTap: {
                                    viewModel.selectedImages.remove(images)
                                }, uiImage: images)
                            }
                        }
                    }
                }
                
                if viewModel.selectedImages.count < 5 {
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
