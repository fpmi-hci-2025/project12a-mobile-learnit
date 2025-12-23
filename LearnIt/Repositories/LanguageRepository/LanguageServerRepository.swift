import Foundation

final class LanguageServerRepository {
    static let shared: LanguageServerRepository = .init()
    
    private let client: Networking = NetworkClient.app
    
    private init() { }
}

extension LanguageServerRepository: LanguageRepository {
    func getLanguage(id: UUID) async throws -> Language? {
        try await client.request(AppEndpoint.language(languageId: id))
    }
    
    func getAllLanguages() async throws -> [Language] {
        try await client.request(AppEndpoint.allLanguages)
    }
}
