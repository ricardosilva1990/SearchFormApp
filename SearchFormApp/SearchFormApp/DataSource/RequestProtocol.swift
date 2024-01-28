import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol RequestProtocol {
    associatedtype ReturnType: Codable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var client: String { get }
    var queryItems: [String: Any]? { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
}

// MARK: - Default Values
extension RequestProtocol {
    var method: HTTPMethod { .get }
    var contentType: String { "application/json" }
    var client: String { "ios" }
    var queryItems: [String: Any]? { nil }
    var body: [String: Any]? { nil }
    var headers: [String: String]? { ["contentType": self.contentType, "client": self.client] }
}

// MARK: - Utility Methods
extension RequestProtocol {
    /// Serializes an HTTP dictionary to a JSON Data Object
    private func requestHTTPBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params, let httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        else { return nil }
        
        return httpBody
    }
    
    private func requestQueryItemsFrom(params: [String: Any]?) -> [URLQueryItem]? {
        guard let params = params else { return nil }
        return params.map { item in
            var value: String?
            if let val = item.value as? String {
                value = val
            } else {
                value = "\(item.value)"
            }
            return URLQueryItem(name: item.key, value: value)
        }
    }
    
    /// Transforms a URL into a URL Request Object,.
    func toURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(self.path)"
        urlComponents.queryItems = requestQueryItemsFrom(params: queryItems)
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = requestHTTPBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        return request
    }
}
