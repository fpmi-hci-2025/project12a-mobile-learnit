//
//  LanguageRepository.swift
//  LearnIt
//
//  Created by Egor on 3.12.25.
//


import Foundation

protocol LanguageRepository {
    func getLanguage(id: UUID) async throws -> Language?
    func getAllLanguages() async throws -> [Language]
}
