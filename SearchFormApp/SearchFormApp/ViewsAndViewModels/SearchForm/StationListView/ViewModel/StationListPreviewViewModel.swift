import Combine

class StationListViewPreviewModel: StationListViewModelProtocol {
    var title: String = "Best Station Picker"
    
    @Published var stationArray: [StationViewModel] = []
    var stationArrayPublisher: Published<[StationViewModel]> { _stationArray }
    var stationArrayPublished: Published<[StationViewModel]>.Publisher { $stationArray }
    
    func fetchStationList() {
        stationArray = [StationViewModel(stationModel: StationModel(code: "BST", name: "Best Station"))]
    }
    
    func titleLabel(for selectedStation: StationViewModel?) -> String { "Selected Station : \(String(describing: selectedStation != nil ? selectedStation?.code : "None"))" }
    
    var noResultsLabel: String { "Nothing to show..." }
}
