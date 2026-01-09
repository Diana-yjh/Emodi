//
//  SettingFactoryImplement.swift
//  SettingComposition
//
//  Created by Yejin Hong on 1/9/26.
//  Copyright © 2026 diana. All rights reserved.
//

import SwiftUI
import SettingPresentation

public final class SettingFactoryImplement: SettingFactory {
    public init() {}
    
    public func makeSettingView() -> SettingView {
        return SettingView()
    }
    
    public func makeLicenseView() -> LicenseView {
        return LicenseView()
    }
    
    public func makeLibraryInfoView() -> LibraryInfoView {
        return LibraryInfoView()
    }
}
