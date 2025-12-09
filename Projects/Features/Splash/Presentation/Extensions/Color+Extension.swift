//
//  Color+Extension.swift
//  Splash
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem

enum ButtonType {
    case enable
    case disable
    case menu
}

extension Color {
    static func buttonColor(_ type: ButtonType) -> Color {
        switch type {
        case .enable:
            DesignSystemAsset.enableButton.swiftUIColor
        case .disable:
            DesignSystemAsset.disableButton.swiftUIColor
        case .menu:
            DesignSystemAsset.menuButton.swiftUIColor
        }
    }
}
