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
                    
                    DiarySectionView()
                        .padding()
                        .onTapGesture {
                            showAddDiaryPopup = true
                        }
                    
                    PhotoSectionView()
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
            
            Button {
                
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
                    
                    DiaryView(showAddDiaryPopup: $showAddDiaryPopup)
                        .padding()
                }
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
                    withAnimation {
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

struct DiarySectionView: View {
    var diary: String = "Tap to add diary"
    
    var body: some View {
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
            
            VStack {
                Text(diary)
                    .font(DSFont.medium(16))
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
            }
        }
    }
}

struct PhotoSectionView: View {
    var body: some View {
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

#Preview {
    AddMoodView()
}
