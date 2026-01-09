//
//  HomeView.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/5/25.
//

import SwiftUI
import DesignSystem

public struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    @State private var navigationPath: HomeDestinations = .init()
    @State private var opacity: Double = 0
    @State private var date: Date = .now
    @Binding var isTabBarHidden: Bool
    
    let factory: HomeFactory
    
    public init(factory: HomeFactory, isTabBarHidden: Binding<Bool>, viewModel: HomeViewModel) {
        self.factory = factory
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _isTabBarHidden = isTabBarHidden
    }
    
    public var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                VStack(alignment: .leading) {
                    MainNavigationBar(theme: .light, onMenuTab: {}, onAccountTab: {})
                        .frame(height: 30)
                    
                    Group {
                        Text("오늘의 기분")
                            .font(DSFont.bold(30))
                            .foregroundStyle(.white)
                            .padding(.top)
                            .shadow(radius: 5)
                        Text("오늘은 어떤 하루가 될까?")
                            .font(DSFont.medium(16))
                            .foregroundStyle(.white)
                            .padding(.top, -5)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    contentSectionView
                        .padding(.top)
                        .ignoresSafeArea()
                }
            }
            .overlay {
                if viewModel.showAddMoodAlert {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.1)) {
                                    self.viewModel.showAddMoodAlert = false
                                }
                            }
                        
                        WarningAlert(title: "과거의 기분은 추가할 수 없어요", onClickOK: {
                            self.viewModel.showAddMoodAlert = false
                        })
                        .padding()
                    }
                }
            }
            .background(
                Image(uiImage: DesignSystemAsset.background.image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .navigationDestination(for: Homes.self) { views in
                switch views {
                case .addMood:
                    AddMoodView(viewModel: factory.makeAddMoodViewModel(date: self.date))
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMoodLists()
            }
        }
        .onChange(of: navigationPath) { newPath in
            self.isTabBarHidden = !newPath.isEmpty
            
            if newPath.isEmpty {
                Task {
                    await viewModel.fetchMoodLists()
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    var contentSectionView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack {
                DateBar(date: $date)
                    .padding(.horizontal, 30)
                    .frame(height: 100)
                    .onChange(of: date) { newDate in
                        viewModel.selectedDate = "\(newDate.toYear()).\(newDate.toMonthDate())"
                        Task {
                            viewModel.clearMoodList()
                            await viewModel.fetchMoodLists()
                        }
                    }
                
                HStack() {
                    MotionHistoryView(historyList: $viewModel.moodList, onAddButtonTap: {
                        if date.toMonthDate() == Date().toMonthDate() {
                            self.isTabBarHidden = true
                            navigationPath.append(.addMood)
                        } else {
                            self.viewModel.showAddMoodAlert = true
                        }
                    })
                }
                .padding(.horizontal)
                .padding(.vertical, -40)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}
