import Foundation

struct StationViewModel {
    private let stationModel: StationModel
    
    init(stationModel: StationModel) {
        self.stationModel = stationModel
    }
    
    var code: String {
        self.stationModel.code
    }
    
    var name: String {
        self.stationModel.name
    }
}

extension StationViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(self.code)
    }
    
    static func == (lhs: StationViewModel, rhs: StationViewModel) -> Bool {
        lhs.code == rhs.code
    }
}
