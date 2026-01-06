//
//  HomeFactory.swift
//  HomeComposition
//
//  Created by Yejin Hong on 12/26/25.
//

import SwiftUI

public protocol HomeFactory {
    func makeHomeView(isTabBarHidden: Binding<Bool>) -> HomeView
    func makeAddMoodViewModel(date: Date) -> AddMoodViewModel
}
