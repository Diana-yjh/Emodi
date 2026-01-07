//
//  AnalysisView.swift
//  AnalysisData
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem

public struct AnalysisView: View {
    @ObservedObject var viewModel: AnalysisViewModel
    
    public init(viewModel: AnalysisViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            VStack {
                MainNavigationBar(theme: .light, onMenuTab: {}, onAccountTab: {})
                    .frame(height: 30)
                
                ScrollView {
                    ChangeMonthView(month: $viewModel.month, onTabBeforeButton: {
                        viewModel.changeMonth(by: -1)
                        viewModel.extractDays(currentMonth: viewModel.month)
                    }, onTabAfterButton: {
                        viewModel.changeMonth(by: +1)
                        viewModel.extractDays(currentMonth: viewModel.month)
                    })
                    .frame(maxWidth: 300)
                    
                    EmodiCalendarView(dateValues: $viewModel.days, selectedDate: $viewModel.selectedDate)
                        .frame(height: viewModel.calendarHeight)
                        .padding()
                    
                    EmodiAnalysisView()
                        .frame(height: 220)
                        .padding()
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            viewModel.extractDays(currentMonth: viewModel.month)
        }
        .background {
            Image(uiImage: DesignSystemAsset.analysisBackground.image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

struct ChangeMonthView: View {
    @Binding var month: Date
    var onTabBeforeButton: () -> Void
    var onTabAfterButton: () -> Void
    
    var body: some View {
        HStack {
            Button {
                onTabBeforeButton()
            } label: {
                Image(systemName: "chevron.left.circle")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Text(month.toString(in: "yyyy년 MM월"))
                .font(DSFont.bold(26))
                .foregroundStyle(.white)
                .frame(height: 40)
            
            Spacer()
            
            Button {
                onTabAfterButton()
            } label: {
                Image(systemName: "chevron.right.circle")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.white)
            }
        }
        .shadow(radius: 5)
    }
}

#Preview {
    AnalysisView(viewModel: AnalysisViewModel())
}
