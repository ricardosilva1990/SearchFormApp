@testable import SearchFormApp

struct StationModelMocks {
    static let porto = StationModel(code: "OPO", name: "Porto")
    static let barcelona = StationModel(code: "BCN", name: "Barcelona")
    static let madrid = StationModel(code: "MAD", name: "Madrid")
}

struct StationListModelMocks {
    static let list = StationListModel(stations: [StationModelMocks.barcelona, StationModelMocks.madrid, StationModelMocks.porto])
}
