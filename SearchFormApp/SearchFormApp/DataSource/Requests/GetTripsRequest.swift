struct GetTripsRequest: RequestProtocol {
    typealias ReturnType = TripResponseModel
    
    var path: String = "/Availability"
    var queryItems: [String: Any]?
    
    init(queryItems: [String: Any]? = nil) {
        self.queryItems = queryItems
    }
}
