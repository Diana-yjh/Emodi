//
//  MoodRepository.swift
//  HomeData
//
//  Created by Yejin Hong on 12/10/25.
//

import Foundation

public protocol MoodRepository {
    func addMoodDiary(mood: MoodEntity, photo: Data?, completion: @escaping(Result<Void, Error>) -> Void)
    func fetchMoodDiary(date: Date, completion: @escaping(Result<[MoodEntity], Error>) -> Void)
    func deleteMoodDiary(date: Date, diaryID: Int, completion: @escaping(Result<Void, Error>) -> Void)
}
