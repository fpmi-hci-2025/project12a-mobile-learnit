import SwiftUI

enum Screen: Identifiable, Hashable {
    case onBoardingScreen
    case tabContainerView
    case selectLanguage
    case quizScreen
    case home
    case topicsList
    case settings
    case signUp
    case quizResult
    
    var id: UUID {
        UUID()
    }
}
