//
//  AnswerSwiftData.swift
//  LearnIt
//
//  Created by Egor on 3.12.25.
//

import Foundation
import SwiftData

@Model
final class AnswerDataModel {
    @Attribute(.unique) let id: UUID
    var text: String
    var isCorrect: Bool?
    
    init(id: UUID, text: String, isCorrect: Bool? = nil) {
        self.id = id
        self.text = text
        self.isCorrect = isCorrect
    }
    
    func toDomain() -> Answer {
        Answer(id: id, text: text, isCorrect: isCorrect)
    }
}
