//
//  LanguageDataModel.swift
//  LearnIt
//
//  Created by Egor on 3.12.25.
//
import Foundation
import SwiftData

@Model
final class LanguageDataModel {
    @Attribute(.unique) let id: UUID
    var name: String
    @Relationship(deleteRule: .cascade) var topics: [TopicDataModel]
    
    init(id: UUID, name: String, topics: [TopicDataModel] = []) {
        self.id = id
        self.name = name
        self.topics = topics
    }
    
    func toDomain() -> Language {
        Language(
            id: id,
            name: name,
            topics: topics.map { $0.toDomain() }
        )
    }
}

#if DEBUG
extension LanguageDataModel {
    static let testData = Language.testData.map(\.toDataModel)
}

#endif
