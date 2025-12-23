//
//  QuestionDataModel.swift
//  LearnIt
//
//  Created by Egor on 3.12.25.
//
import SwiftData
import Foundation

@Model
final class QuestionDataModel {
    @Attribute(.unique) let id: UUID
    var text: String
    var answer: String?
    var type: QuestionType?
    
    @Relationship(deleteRule: .cascade) var answers: [AnswerDataModel]?
    @Relationship(deleteRule: .cascade) var answerSequence: [AnswerDataModel]?
    
    init(
        id: UUID,
        text: String,
        answer: String? = nil,
        answers: [AnswerDataModel]? = nil,
        answerSequence: [AnswerDataModel]? = nil,
        type: QuestionType? = nil
    ) {
        self.id = id
        self.text = text
        self.answer = answer
        self.answers = answers
        self.answerSequence = answerSequence
        self.type = type
    }
    
    func toDomain() -> Question {
        Question(
            id: id,
            text: text,
            answer: answer,
            answers: answers?.map { $0.toDomain() },
            answerSequence: answerSequence?.map { $0.toDomain() },
            type: type
        )
    }
}
