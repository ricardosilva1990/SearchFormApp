import Foundation

extension URLSession {
    static var simulatedStationListURLSession: URLSession { simulatedURLSession(forResource: "SimulatedStationList") }
    static var simulatedTripSarchResultsURLSession: URLSession { simulatedURLSession(forResource: "SimulatedTripSearchResults") }
}

private extension URLSession {
    private enum NetworkError: Error {
        case encodingError
    }
    
    private static func getData(from resource: String) -> Data? {
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    private static func simulatedURLSession(forResource resource: String) -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [SimulatedURLProtocol.self]
        
        SimulatedURLProtocol.requestHandler = { request in
            guard let url = request.url,
                  let data = getData(from: resource)
            else {
                throw NetworkError.encodingError
            }
        
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        return self.init(configuration: configuration)
    }
}
