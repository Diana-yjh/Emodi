//
//  AnalysisFactoryImplement.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

public final class AnalysisFactoryImplement: AnalysisFactory {
    
    public init() {}
    
    public func makeAnalysisView() -> AnalysisView {
        return AnalysisView(viewModel: AnalysisViewModel())
    }
}
