import SwiftUI
import SwiftData

struct CoordinatorView: View {
    
    @StateObject private var selectedLanguageViewModel: SelectedLanguageViewModel
    
    private let container: ModelContainer
    
    init() {
        //setup SwiftData
        do {
            container = try ModelContainer(for: LanguageDataModel.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
        
        //setup Repository
        let repository = LanguageLocalRepository(modelContext: container.mainContext)
        
        _selectedLanguageViewModel = StateObject(wrappedValue: SelectedLanguageViewModel(languageRepository: repository))
    }
    
    var body: some View {
        TopicsListScreen()
            .environmentObject(selectedLanguageViewModel)
    }
}

#Preview {
    CoordinatorView()
}

