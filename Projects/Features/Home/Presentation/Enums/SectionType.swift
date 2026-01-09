//
//  SectionType.swift
//  HomePresentation
//
//  Created by Yejin Hong on 12/18/25.
//

enum SectionType {
    case mood
    case diary
    case photo
    
    var icon: String {
        switch self {
        case .mood:
            ""
        case .diary:
            "book"
        case .photo:
            "camera"
        }
    }
    
    var title: String {
        switch self {
        case .mood:
            "기분"
        case .diary:
            "일기"
        case .photo:
            "사진"
        }
    }
}
