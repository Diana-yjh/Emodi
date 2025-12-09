//
//  Font+Extension.swift
//  HomeData
//
//  Created by Yejin Hong on 12/8/25.
//

import SwiftUI
import DesignSystem

public enum DSFont: Sendable {
    static func bold(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.GmarketSans.bold.swiftUIFont(size: size)
    }
    
    static func medium(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.GmarketSans.medium.swiftUIFont(size: size)
    }
    
    static func light(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.GmarketSans.light.swiftUIFont(size: size)
    }
}
