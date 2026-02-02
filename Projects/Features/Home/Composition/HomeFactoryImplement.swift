//
//  HomeFactoryImplement.swift
//  HomeComposition
//
//  Created by Yejin Hong on 12/26/25.
//

import HomeDomain
import HomeData
import HomePresentation
import Core
import SwiftUI

public final class HomeFactoryImplement: HomeFactory {
    private let firestoreService: FirestoreServiceProtocol
    private let firebaseStorageService: FirebaseStorageProtocol
    
    public init(firestoreService: FirestoreServiceProtocol? = nil, firebaseStorageService: FirebaseStorageProtocol? = nil) {
        self.firestoreService = firestoreService ?? FirestoreService()
        self.firebaseStorageService = firebaseStorageService ?? FirebaseStorageService()
    }
    
    public func makeHomeView(isTabBarHidden: Binding<Bool>) -> HomeView {
        let moodRemoteDataSource = MoodRemoteDataSourceImplement(
            firestoreService: firestoreService,
            firebaseStorageService: firebaseStorageService
        )
        
        let moodRepository = MoodRepositoryImplement(remoteDataSource: moodRemoteDataSource)
        let moodUseCase = MoodUseCase(repository: moodRepository)
        
        return HomeView(factory: self, isTabBarHidden: isTabBarHidden, moodUseCase: moodUseCase)
    }
    
    public func makeAddMoodViewModel(date: Date, moodData: Mood?) -> AddMoodViewModel {
        let moodRemoteDataSource = MoodRemoteDataSourceImplement(
            firestoreService: firestoreService,
            firebaseStorageService: firebaseStorageService
        )
        
        let moodRepository = MoodRepositoryImplement(remoteDataSource: moodRemoteDataSource)
        let moodUseCase = MoodUseCase(repository: moodRepository)
        
        let photoRepository = PhotoRepositoryImplement()
        let photoUseCase = PhotoUseCase(repository: photoRepository)
        
        return AddMoodViewModel(photoUseCase: photoUseCase, moodUseCase: moodUseCase, moodData: moodData)
    }
}

