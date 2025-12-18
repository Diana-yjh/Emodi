//
//  AddMoodView.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem

struct AddMoodView: View {
    @ObservedObject private var viewModel: AddMoodViewModel = AddMoodViewModel()
    @State private var showAddDiaryPopup = false
    @State private var showSavePopup = false
    @State private var showSaveWarningPopup = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            SubNavigationBar(theme: .dark, onBackButtonTab: {
                dismiss()
            })
            
            ScrollView {
                VStack {
                    Text("How do you feel Now?")
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
            
            Button {
                if viewModel.canSave {
                    showSavePopup = true
                } else {
                    showSaveWarningPopup = true
                }
            } label: {
                Text("저장하기")
                    .font(DSFont.bold(20))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(DesignSystemAsset.enableButton.swiftUIColor)
                            .shadow(radius: 3)
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
                        showSavePopup = false
                        dismiss()
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
                Button {} label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
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

#Preview {
    AddMoodView()
}
