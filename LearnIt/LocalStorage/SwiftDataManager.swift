import SwiftData

final class SwiftDataManager {
    static let shared = SwiftDataManager()
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    private init() {
        do {
            modelContainer = try ModelContainer(for: TopicDataModel.self, QuestionDataModel.self, AnswerDataModel.self)
            modelContext = ModelContext(modelContainer)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
