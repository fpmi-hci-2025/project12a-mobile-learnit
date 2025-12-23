import Foundation
import SwiftData
import SwiftUI

@Observable
final class LanguageLocalRepository {
    private let context: ModelContext
    
    init(modelContext: ModelContext) {
        self.context = modelContext
//        deleteAllLanguages()
        addAllLanguages()
    }
    
    func addAllLanguages() {
        for language in Language.testData {
            addLanguage(language)
        }
    }
    
    func addLanguage(_ language: Language) {
        context.insert(language.toDataModel)
        saveChangesInCurrentContext()
    }
    
    func deleteAllLanguages() {
        do {
            try context.delete(model: LanguageDataModel.self)
        } catch {
            print("Error deleting all: \(error)")
        }
    }
    
    func deleteItem(by id: UUID) {
        let predicate = #Predicate<LanguageDataModel> { item in
            item.id == id
        }
        
        let descriptor = FetchDescriptor<LanguageDataModel>(predicate: predicate)
        
        do {
            let items = try context.fetch(descriptor)
            for item in items {
                context.delete(item)
            }
            try context.save()
        } catch {
            print(error)
        }
    }
}

extension LanguageLocalRepository: LanguageRepository {
    func getLanguage(id: UUID) async throws -> Language? {
        nil
    }
    
    func getAllLanguages() async throws -> [Language] {
        try await getAllLanguagesFromSwiftData()
    }
    
    func saveChangesInCurrentContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

private extension LanguageLocalRepository {
    func getAllLanguagesTestData() -> [Language] {
        Language.testData
    }
    
    func getAllLanguagesFromSwiftData() async throws -> [Language] {
        let descriptor = FetchDescriptor<LanguageDataModel>(sortBy: [SortDescriptor(\.name)])
        
        return try context.fetch(descriptor).map {
            $0.toDomain()
        }
    }
    
    func handleSaveError(_ error: Error) {
        print("Save failed: (error.localizedDescription)")

        // Восстановление контекста
        context.rollback()
        
        // Уведомление пользователя (в реальном приложении)
        // errorHandler.notifyUser(error)
    }
}

#Preview {
    CoordinatorView()
}
