//
//  Array+Extension.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/29/25.
//

import SwiftUI

extension Array where Element: Equatable {
    mutating func remove(_ target: Element) {
        guard let index = firstIndex(of: target) else { return }
        remove(at: index)
    }
}
