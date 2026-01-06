//
//  MoodTypes.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/18/25.
//
import SwiftUI
import DesignSystem

enum MoodType: Hashable {
    case best, good, normal, bad, worst
    case none
    
    // 숫자로 MoodType 생성
    init(index: Int) {
        switch index {
        case 5: self = .best
        case 4: self = .good
        case 3: self = .normal
        case 2: self = .bad
        case 1: self = .worst
        default: self = .none
        }
    }
    
    static func title(for index: Int) -> String {
        return MoodType(index: index).title
    }
    
    static func image(for index: Int) -> UIImage {
        return MoodType(index: index).image
    }
    
    var image: UIImage {
        switch self {
        case .best:
            DesignSystemAsset.greenFace.image
        case .good:
            DesignSystemAsset.blueFace.image
        case .normal:
            DesignSystemAsset.purpleFace.image
        case .bad:
            DesignSystemAsset.orangeFace.image
        case .worst:
            DesignSystemAsset.redFace.image
        case .none:
            DesignSystemAsset.defaultFace.image
        }
    }
    
    var index: Int {
        switch self {
        case .best: 5
        case .good: 4
        case .normal: 3
        case .bad: 2
        case .worst: 1
        case .none: 0
        }
    }
    
    var title: String {
        switch self {
        case .best: "매우 좋음"
        case .good: "좋음"
        case .normal: "보통"
        case .bad: "나쁨"
        case .worst: "매우 나쁨"
        case .none: "알 수 없음"
        }
    }
}
