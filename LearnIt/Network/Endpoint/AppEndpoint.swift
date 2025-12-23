import Foundation

enum AppEndpoint {
    // MARK: - User Service
    case register
    case login
    
    // MARK: - Content Service (Languages)
    case allLanguages
    case language(languageId: UUID)
    case createLanguage
    case createTopic(languageId: UUID)
    case createQuestion(topicId: UUID)
    
    // MARK: - Content Service (Questions & Progress)
    case checkAnswer(questionId: UUID)
    case completeTopic(topicId: UUID)
}

extension AppEndpoint: Endpoint {
    var baseURL: URL {
        switch self {
            case .register, .login:
                return URL(string: "http://localhost:8000")!
            default:
                return URL(string: "http://localhost:8001")!
        }
    }
    
    var path: String {
        switch self {
        // User Service
        case .register:
            return "/register"
        case .login:
            return "/login"
            
        // Content Service
        case .allLanguages:
            return "/languages"
        case .language(let languageId):
            return "/languages/\(languageId)"
        case .createLanguage:
            return "/languages"
        case .createTopic(let languageId):
            return "/languages/\(languageId)/topics"
        case .createQuestion(let topicId):
            return "/topics/\(topicId)/questions"
        case .checkAnswer(let questionId):
            return "/questions/\(questionId)/check"
        case .completeTopic(let topicId):
            return "/topics/\(topicId)/complete"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register, .login, .createLanguage, .createTopic, .createQuestion, .checkAnswer, .completeTopic:
            return .post
        case .allLanguages, .language:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .register, .login, .allLanguages, .language:
            return ["Content-Type": "application/json"]
        default:
            // Для всех остальных эндпоинтов требуется JWT токен
            // Токен будет добавляться через NetworkManager
            return [
                "Content-Type": "application/json",
                //"Authorization": "Bearer \(AuthManager.shared.token ?? "")"
            ]
        }
    }
    
    var body: Data? {
        // Body будет передаваться через NetworkManager при вызове
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
