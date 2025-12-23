//
//  TopicDataModel.swift
//  LearnIt
//
//  Created by Egor on 3.12.25.
//
import Foundation
import SwiftData

@Model
final class TopicDataModel {
    @Attribute(.unique) let id: UUID
    var name: String
    @Relationship(deleteRule: .cascade) var questions: [QuestionDataModel]
    var isCompleted: Bool
    
    init(id: UUID, name: String, questions: [QuestionDataModel] = [], isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.questions = questions
        self.isCompleted = isCompleted
    }
    
    func toDomain() -> Topic {
        Topic(
            id: id,
            name: name,
            questions: questions.map { $0.toDomain() },
            isCompleted: isCompleted
        )
    }
}
