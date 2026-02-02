//
//  HomeView.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/5/25.
//

import SwiftUI
import DesignSystem
import HomeDomain

enum HomeViewText {
    case title
    case subtitle
    case pastMoodError
    
    var text: String {
        switch self {
        case .title:
            "오늘의 기분"
        case .subtitle:
            "오늘은 어떤 하루인가요?"
        case .pastMoodError:
            "과거의 기분은 추가할 수 없어요"
        }
    }
}

public struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var navigationPath: HomeDestinations = .init()
    @State private var opacity: Double = 0
    @State private var date: Date = .now
    @Binding var isTabBarHidden: Bool
    
    let factory: HomeFactory
    
    public init(factory: HomeFactory, isTabBarHidden: Binding<Bool>, moodUseCase: MoodUseCaseProtocol) {
        self.factory = factory
        _isTabBarHidden = isTabBarHidden
        _viewModel = StateObject(wrappedValue: HomeViewModel(moodUseCase: moodUseCase))
    }
    
    public var body: some View {
        NavigationStack(path: $navigationPath) {
            mainContent
                .overlay { alertOverlay }
                .background { backgroundImage }
                .navigationDestination(for: Homes.self, destination: destinationView)
        }
        .onAppear(perform: onViewAppear)
        .onChange(of: navigationPath, perform: onNavigationPathChange)
        .navigationBarHidden(true)
    }
    
    private var mainContent: some View {
        ZStack {
            VStack(alignment: .leading) {
                MainNavigationBar(theme: .light, onMenuTab: {}, onAccountTab: {})
                    .frame(height: 50)
                
                headerSection
                
                Spacer()
                
                contentSection
                    .padding(.top)
                    .ignoresSafeArea()
            }
        }
    }
    
    private var contentSection: some View {
        ContentSectionView(
            viewModel: viewModel,
            date: $date,
            isTabBarHidden: $isTabBarHidden,
            onAddButtonTap: handleAddButtonTap,
            onMoodCellTap: handleMoodCellTap
        )
    }
    
    private func handleAddButtonTap() {
        if date.toMonthDate() == Date().toMonthDate() {
            isTabBarHidden = true
            navigationPath.append(.addMood(moodData: nil))
        } else {
            viewModel.showAddMoodAlert = true
        }
    }
    
    private func handleMoodCellTap(_ moodData: Mood) {
        isTabBarHidden = true
        
        navigationPath.append(.addMood(moodData: moodData))
    }
    
    private var headerSection: some View {
        Group {
            Text(HomeViewText.title.text)
                .font(DSFont.bold(30))
                .foregroundStyle(.white)
                .padding(.top)
                .shadow(radius: 5)
            Text(HomeViewText.subtitle.text)
                .font(DSFont.medium(16))
                .foregroundStyle(.white)
                .padding(.top, -5)
                .shadow(radius: 5)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var alertOverlay: some View {
        if viewModel.showAddMoodAlert {
            alertContent
        }
    }
    
    private var alertContent: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture(perform: dismissAlert)
            
            WarningAlert(title: HomeViewText.pastMoodError.text, onClickOK: dismissAlert)
                .padding()
        }
    }
    
    private var backgroundImage: some View {
        Image(uiImage: DesignSystemAsset.background.image)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func destinationView(for destination: Homes) -> some View {
        switch destination {
        case .addMood(let moodData):
            makeAddMoodView(moodData: moodData)
        }
    }
    
    private func makeAddMoodView(moodData: Mood?) -> some View {
        AddMoodView(factory: factory, date: date, moodData: moodData)
    }
    
    private func dismissAlert() {
        withAnimation(.linear(duration: 0.1)) {
            viewModel.showAddMoodAlert = false
        }
    }
    
    private func onViewAppear() {
        Task {
            await viewModel.fetchMoodLists()
        }
    }
    
    private func onNavigationPathChange(_ newPath: HomeDestinations) {
        isTabBarHidden = !newPath.isEmpty
        
        if newPath.isEmpty {
            Task {
                viewModel.clearMoodList()
                await viewModel.fetchMoodLists()
            }
        }
    }
}

struct ContentSectionView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var date: Date
    @Binding var isTabBarHidden: Bool
    
    var onAddButtonTap: () -> Void
    var onMoodCellTap: (Mood) -> Void
    
    init(
        viewModel: HomeViewModel,
        date: Binding<Date>,
        isTabBarHidden: Binding<Bool>,
        onAddButtonTap: @escaping () -> Void,
        onMoodCellTap: @escaping (Mood) -> Void
    ) {
        self.viewModel = viewModel
        self._date = date
        self._isTabBarHidden = isTabBarHidden
        self.onAddButtonTap = onAddButtonTap
        self.onMoodCellTap = onMoodCellTap
    }
    
    var body: some View {
        ZStack {
            backgroundCard
            contentVStack
        }
    }
    
    private var backgroundCard: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.white)
            .shadow(radius: 5)
    }
    
    private var contentVStack: some View {
        VStack {
            dateBarSection
            historySection
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var dateBarSection: some View {
        DateBar(date: $date)
            .padding(.horizontal, 30)
            .frame(height: 100)
            .onChange(of: date, perform: onDateChange)
    }
    
    private var historySection: some View {
        HStack {
                MotionHistoryView(
                    historyList: $viewModel.moodList,
                    isTabBarHidden: $isTabBarHidden,
                    onAddButtonTap: onAddButtonTap,
                    onMoodCellTap: onMoodCellTap
                )
            }
            .padding(.horizontal)
            .padding(.vertical, -40)
    }
    
    @State private var lastScrollOffset: CGFloat = 0
    
    private func handleScroll(_ offset: CGFloat) {
        let delta = offset - lastScrollOffset
        
        if delta < -10 {
            if !isTabBarHidden {
                isTabBarHidden = true
            }
        } else if delta > 10 {
            if isTabBarHidden {
                isTabBarHidden = false
            }
        }
        
        lastScrollOffset = offset
    }
    
    private func onDateChange(_ newDate: Date) {
        viewModel.selectedDate = "\(newDate.toYear()).\(newDate.toMonthDate())"
        Task {
            viewModel.clearMoodList()
            await viewModel.fetchMoodLists()
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
