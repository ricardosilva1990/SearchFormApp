import Combine

struct APIClient {
    let baseURL: String
    let networkDispatch: NetworkDispatcher
    
    init(baseURL: String, networkDispatch: NetworkDispatcher = NetworkDispatcher()) {
        self.baseURL = baseURL
        self.networkDispatch = networkDispatch
    }
    
    /// Dispatches a Request
    func dispatch<Request: RequestProtocol>(_ request: Request) -> AnyPublisher<Request.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.toURLRequest(baseURL: baseURL) else {
            return Fail(outputType: Request.ReturnType.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        let requestPublisher: AnyPublisher<Request.ReturnType, NetworkRequestError> = networkDispatch.dispatch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
}
