struct GetStationsRequest: RequestProtocol {
    typealias ReturnType = StationListModel
    
    var path: String = "/stations.json"
}
