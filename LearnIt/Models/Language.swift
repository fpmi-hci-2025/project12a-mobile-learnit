import Foundation

struct Language: Codable {
    let id: UUID
    let name: String
    let topics: [Topic]
    
    var toDataModel: LanguageDataModel {
        LanguageDataModel(id: id, name: name, topics: topics.map(\.toDataModel))
    }
}

#if DEBUG
extension Language {
    static let testData = [
        Language(id: UUID(), name: "Python", topics: Topic.testDataPython),
        Language(id: UUID(), name: "Swift", topics: []),
    ]
}
#endif
