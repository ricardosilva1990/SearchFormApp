import Foundation
@testable import SearchFormApp

struct TripSearchResultsViewModelMocks {
    private static var urlSession: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession.init(configuration: configuration)
    }
    
    private static let networkDispatcher = NetworkDispatcher(urlSession: urlSession)
    static let apiClient = APIClient(baseURL: "http://nowhere.com", networkDispatch: networkDispatcher)
    
    static let currency = "USD"
}
