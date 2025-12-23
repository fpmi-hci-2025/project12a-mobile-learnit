import Foundation

struct Question: Codable {
    let id: UUID
    let text: String
    let answer: String?
    let answers: [Answer]?
    let answerSequence: [Answer]?
    let type: QuestionType?
    
    enum CodingKeys: String, CodingKey {
        case id, text, answer, answers
        case answerSequence = "answer_sequence"
        case type
    }
    
    var toDataModel: QuestionDataModel {
        QuestionDataModel(
            id: id,
            text: text,
            answer: answer,
            answers: answers == nil ? nil : answers!.map(\.toDataModel),
            answerSequence: answerSequence == nil ? nil : answerSequence!.map(\.toDataModel),
            type: type
        )
    }
}

#if DEBUG
extension Question {
    static let testData: [Question] = [
        Question(
            id: UUID(),
            text: "Выберите правильный ответ",
            answer: nil,
            answers: [
                Answer(id: UUID(), text: "Правильный ответ", isCorrect: true),
                Answer(id: UUID(), text: "Неправильный ответ", isCorrect: false)
            ],
            answerSequence: nil,
            type: .singleChoice
        ),
        
        Question(
            id: UUID(),
            text: "Расставьте слова в правильном порядке",
            answer: nil,
            answers: nil,
            answerSequence: [
                Answer(id: UUID(), text: "Я", isCorrect: nil),
                Answer(id: UUID(), text: "люблю", isCorrect: nil),
                Answer(id: UUID(), text: "Swift", isCorrect: nil)
            ],
            type: .sequence
        ),
        
        Question(
            id: UUID(),
            text: "Ключевой знак обозначающий опционал",
            answer: "?",
            answers: nil,
            answerSequence: nil,
            type: .singleWord
        ),
    ]
}
#endif
