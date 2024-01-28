import Combine
import Foundation

enum NetworkRequestError: Error {
    case badRequest
    case httpError(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}

struct NetworkDispatcher {
    let urlSession: URLSession
    let decoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    /// Dispatches an URL Request and returns a publisher
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        urlSession
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    throw NetworkRequestError.httpError(response.statusCode)
                }
                return data
            }
            .decode(type: ReturnType.self, decoder: decoder)
            .mapError { handleError($0) }
            .eraseToAnyPublisher()
    }
}

private extension NetworkDispatcher {
    /// Parses the Publisher errors and returns the related `NetworkRequestError` one.
    func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError: return .decodingError
        case let urlError as URLError: return .urlSessionFailed(urlError)
        case let error as NetworkRequestError: return error
        default: return .unknownError
        }
    }
}
