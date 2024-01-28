struct StationModel: Codable {
    let code: String
    let name: String
}

struct StationListModel: Codable {
    let stations: [StationModel]
}
