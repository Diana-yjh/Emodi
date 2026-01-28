//
//  MotionHistoryView.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/14/25.
//

import SwiftUI
import DesignSystem

struct MotionHistoryView: View {
    @Binding var historyList: [Mood]
    
    var onAddButtonTap: () -> Void
    var onMoodCellTap: (Mood) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    onAddButtonTap()
                } label: {
                    Image(uiImage: DesignSystemAsset.plusButton.image)
                        .frame(width: 30, height: 30)
                        .padding(.horizontal)
                }
                
                ZStack {
                    Image(uiImage: DesignSystemAsset.bubble.image)
                        .resizable()
                        .frame(width: 260, height: 100)
                        .padding([.top, .trailing], 10)
                    
                    Text("지금의 기분을 기록해보세요!")
                        .font(DSFont.bold(14))
                        .foregroundStyle(.white)
                        .padding(.trailing, 24)
                        .padding(.bottom, 4)
                }
                
                Spacer()
            }
            
            ScrollView {
                if historyList.isEmpty {
                    DefaultCellView()
                } else {
                    ForEach(historyList, id: \.self) { list in
                        MoodCellView(moodData: Mood(diaryID: list.diaryID, memo: list.memo, mood: list.mood, time: list.time, date: list.date))
                            .onTapGesture {
                                onMoodCellTap(Mood(diaryID: list.diaryID, memo: list.memo, mood: list.mood, time: list.time, date: list.date))
                            }
                    }
                }
            }
            .padding(.top, -40)
        }
    }
}

struct MoodCellView: View {
    var moodData: Mood
    
    var body: some View {
        HStack(alignment: .bottom) {
            Image(uiImage: DesignSystemAsset.timeLine.image)
                .frame(width: 30)
                .padding(.horizontal)
            
            Image(uiImage: MoodType.image(for: moodData.mood))
                .frame(width: 50, height: 24)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(MoodType.title(for: moodData.mood))
                        .font(DSFont.bold(18))
                        .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text(moodData.time.toTime())
                        .font(DSFont.medium(14))
                        .foregroundStyle(DesignSystemAsset.disableButton.swiftUIColor)
                        .padding(.horizontal)
                }
                
                Text(moodData.memo)
                    .font(DSFont.medium(16))
                    .foregroundStyle(.gray)
                    .lineLimit(3)
                    .lineSpacing(3)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
            }
            .frame(height: 24)
            Spacer()
        }
        .frame(height: 100)
    }
}

struct DefaultCellView: View {
    var body: some View {
        HStack(alignment: .bottom) {
            Image(uiImage: DesignSystemAsset.timeLine.image)
                .frame(width: 30)
                .padding(.horizontal)
            
            Image(uiImage: MoodType.none.image)
                .frame(width: 50, height: 24)
            
            VStack(alignment: .leading) {
                Text("기록 없음")
                    .font(DSFont.bold(18))
                    .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                
                Text("오늘의 기분은 어떤가요?")
                    .font(DSFont.medium(16))
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
            }
            .frame(height: 24)
            Spacer()
        }
        .frame(height: 100)
    }
}

#Preview {
    //    MotionHistoryView(onAddButtonTap: {})
}
