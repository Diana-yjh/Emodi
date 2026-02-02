//
//  Mood.swift
//  HomeDomain
//
//  Created by Yejin Hong on 1/6/26.
//  Copyright © 2026 diana. All rights reserved.
//

import Foundation

public struct Mood: Hashable {
    let diaryID: String
    let memo: String
    let mood: Int
    let time: Date
    let date: String
    let photoURL: [String]?
}
