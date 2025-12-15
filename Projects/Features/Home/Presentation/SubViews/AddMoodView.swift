//
//  AddMoodView.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem

struct AddMoodView: View {
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
                    
                    moodSectionView()
                        .padding()
                    
                    diarySectionView(diary: "메모를 작성해 주세요")
                        .padding()
                    
                    photoSectionView()
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
        .background {
            Image(uiImage: DesignSystemAsset.grayBackground.image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
    
    func moodSectionView() -> some View {
        HStack {
            Spacer()
            
            Button {
                
            } label: {
                Image(uiImage: DesignSystemAsset.greenFace.image)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(uiImage: DesignSystemAsset.blueFace.image)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(uiImage: DesignSystemAsset.purpleFace.image)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(uiImage: DesignSystemAsset.orangeFace.image)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(uiImage: DesignSystemAsset.redFace.image)
                    .resizable()
                    .frame(width: 50, height: 50)
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
    
    func diarySectionView(diary: String) -> some View {
        VStack {
            HStack {
                Image(systemName: "book")
                    .resizable()
                    .frame(width: 22, height: 18)
                
                Text("Diary")
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
    
    func photoSectionView() -> some View {
        VStack {
            HStack {
                Image(systemName: "camera")
                    .resizable()
                    .frame(width: 24, height: 18)
                
                Text("Photo")
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
