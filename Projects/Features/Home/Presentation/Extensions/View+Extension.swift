//
//  View+Extension.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/18/25.
//

import SwiftUI

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
