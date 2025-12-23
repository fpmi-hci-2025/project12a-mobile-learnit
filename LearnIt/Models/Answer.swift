import Foundation

struct Answer: Codable, Equatable, Identifiable {
    let id: UUID
    let text: String
    let isCorrect: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, text
        case isCorrect = "is_correct"
    }
    
    var toDataModel: AnswerDataModel {
        AnswerDataModel(id: id, text: text, isCorrect: isCorrect)
    }
}
