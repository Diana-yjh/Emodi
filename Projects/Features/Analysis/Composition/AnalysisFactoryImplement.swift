//
//  AnalysisFactoryImplement.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import AnalysisDomain
import AnalysisData
import AnalysisPresentation
import Core
import SwiftUI

public final class AnalysisFactoryImplement: AnalysisFactory {
    private let firestoreService: FirestoreServiceProtocol
    
    public init(firestoreService: FirestoreServiceProtocol? = nil) {
        self.firestoreService = firestoreService ?? FirestoreService()
    }
    
    public func makeAnalysisView() -> AnalysisView {
        let moodRepository = MoodRepositoryImplement(firestoreService: firestoreService)
        let moodUseCase = MoodUseCases(repository: moodRepository)
        
        return AnalysisView(factory: self ,viewModel: AnalysisViewModel(moodUseCase: moodUseCase))
    }
}
