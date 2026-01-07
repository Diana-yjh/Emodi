//
//  AnalysisFactory.swift
//  AnalysisData
//
//  Created by Yejin Hong on 1/7/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI

public protocol AnalysisFactory {
    func makeAnalysisView() -> AnalysisView
}
