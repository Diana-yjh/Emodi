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
}
