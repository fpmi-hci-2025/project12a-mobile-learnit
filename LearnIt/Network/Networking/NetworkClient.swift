import Foundation

final class NetworkClient: Networking {
    private let baseURL: URL
    private let urlSession: URLSession
    
    static var app: NetworkClient {
        .init(baseURL: URL(string: "http://127.0.0.1:8080")!)
    }
    
    init(baseURL: URL, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let responseData = try await self.requesting(endpoint)
        return try JSONDecoder().decode(T.self, from: responseData)
    }
    
    func request(_ endpoint: Endpoint) async throws {
        try await self.requesting(endpoint)
    }
}
// MARK: - Request builder
private extension NetworkClient {
    @discardableResult
    func requesting(_ endpoint: Endpoint) async throws -> Data {
        let request = try makeRequest(endpoint)
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        return data
    }
    
    func makeRequest(_ endpoint: Endpoint) throws -> URLRequest {
        var url = baseURL.appendingPathComponent(endpoint.path)
        
        if let queryItems = endpoint.queryItems, !queryItems.isEmpty {
            url.append(queryItems: queryItems)
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = endpoint.body
        
        return request
    }
}
