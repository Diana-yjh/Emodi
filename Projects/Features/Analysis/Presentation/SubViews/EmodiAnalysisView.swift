//
//  EmodiAnalysisView.swift
//  AnalysisPresentation
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI
import Charts
import DesignSystem

struct EmodiAnalysisView: View {
    @Binding var diaryList: [DiaryModel]
    @Binding var selectedDate: Date
    
    let xAxisDefaults = ["00:00", "06:00", "12:00", "18:00", "24:00"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("분석표")
                .font(DSFont.bold(18))
                .foregroundStyle(DesignSystemAsset.gray.swiftUIColor)
                .padding(.vertical)
                .padding([.leading, .top], 6)
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
                
                VStack(alignment: .leading) {
                    Text(selectedDate.toString(in: "MM월 dd일"))
                        .font(DSFont.medium(12))
                        .foregroundStyle(.gray)
                        .padding([.leading, .top])
                    
                    Chart {
                        ForEach(diaryList.sorted { $0.time < $1.time }, id: \.self) { diary in
                            LineMark(
                                x: .value("x", diary.time.toString(in: "HH:mm")),
                                y: .value("y", diary.mood)
                            )
                            .interpolationMethod(.cardinal)
                            .symbol {
                                Circle()
                                    .frame(width: 10, height: 10)
                            }
                        }
                        
                        if diaryList.isEmpty {
                            ForEach(xAxisDefaults, id: \.self) { time in
                                LineMark(
                                    x: .value("x", time),
                                    y: .value("y", 0)
                                )
                                .opacity(0)   // 완전 숨김
                            }
                        }
                    }
                    .foregroundStyle(DesignSystemAsset.primary.swiftUIColor)
                    .chartScrollableAxes(.horizontal)
                    .chartXVisibleDomain(length: 5)
                    .chartYScale(domain: 0...4)
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .chartPlotStyle { plot in
                        plot.padding(.top, 10)
                    }
                    .frame(height: 120)
                    .padding()
                }
            }
        }
    }
}
