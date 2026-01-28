//
//  HomeDestinations.swift
//  HomeData
//
//  Created by Yejin Hong on 12/16/25.
//

typealias HomeDestinations = Array<Homes>

enum Homes: Hashable {
    case addMood(moodData: Mood?)
}

