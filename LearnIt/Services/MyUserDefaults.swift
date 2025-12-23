import Foundation

class MyUserDefaults {
    private let defaults = UserDefaults.standard
    static let shared = MyUserDefaults()
    
    private init() { }
    
    var selectedLanguageId: UUID? {
        get { get(UUID.self, forKey: "selectedLanguageId") }
        set { save(newValue, forKey: "selectedLanguageId") }
    }

    func save<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }

    func delete(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
