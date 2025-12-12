//
//  CustomTabViewModel.swift
//  DesignSystem
//
//  Created by Yejin Hong on 12/10/25.
//

import SwiftUI
import Combine

public class CustomTabViewModel: ObservableObject {
    @Published var selectedTab: EmodiTab = .home
}
