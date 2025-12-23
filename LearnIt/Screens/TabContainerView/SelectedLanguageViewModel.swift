import Foundation
import SwiftUI

final class SelectedLanguageViewModel: ObservableObject {
    @Published private(set) var selectedLanguage: Language?
    @Published private(set) var languages: [Language] = []
    
    private let languageRepository: LanguageRepository
    
    init(languageRepository: LanguageRepository) {
        self.languageRepository = languageRepository
        
        loadLanguages()
    }
    
    var progressTopicsPercentCGFloat: CGFloat {
        CGFloat(progressTopicsPercent) / 100
    }
    
    var progressTopicsPercent: Int {
        guard let
                selectedLanguage,
                selectedLanguage.topics.count > 0
        else {
            return 0
        }
        
        var topicsCompletedCount: Double = 0
        
        for topic in selectedLanguage.topics {
            if topic.isCompleted {
                topicsCompletedCount += 1
            }
        }
        
        let answer = topicsCompletedCount / Double(selectedLanguage.topics.count) * 100
        
        return Int(answer)
    }
    
    func setUpSelectedLanguage(_ language: Language) {
        selectedLanguage = language
        MyUserDefaults.shared.selectedLanguageId = language.id
    }
}

private extension SelectedLanguageViewModel {
    func loadLanguages() {
        Task { [weak self] in
            guard let self else { return }
            
            let languages = (try? await languageRepository.getAllLanguages()) ?? []
            
            await MainActor.run {
                self.languages = languages
                self.checkIfUserSelectLanguage()
            }
        }
    }
    
    func checkIfUserSelectLanguage() {
        if let selectedLanguageId = MyUserDefaults.shared.selectedLanguageId {
            
            selectedLanguage = languages.first {
                $0.id == selectedLanguageId
            }
        }
    }
}

#Preview {
    CoordinatorView()
}
