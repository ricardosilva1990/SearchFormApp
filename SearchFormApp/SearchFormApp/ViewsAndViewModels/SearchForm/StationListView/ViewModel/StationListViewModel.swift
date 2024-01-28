import Combine
import Foundation

class StationListViewModel<Request: RequestProtocol>: StationListViewModelProtocol where Request.ReturnType == StationListModel {
    var title: String
    let apiClient: APIClient
    let request: Request
    
    init(title: String, apiClient: APIClient, request: Request) {
        self.title = title
        self.apiClient = apiClient
        self.request = request
    }
    
    @Published var stationArray: [StationViewModel] = []
    var stationArrayPublisher: Published<[StationViewModel]> { _stationArray }
    var stationArrayPublished: Published<[StationViewModel]>.Publisher { $stationArray }
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchStationList() {
        apiClient.dispatch(request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.stationArray = []
                case .finished:
                    break
                }
            } receiveValue: { [weak self] value in
                self?.stationArray = value.stations.map(StationViewModel.init)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Labels
    func titleLabel(for selectedStation: StationViewModel?) -> String {
        var result = title
        if let selectedStation = selectedStation {
            result += ": \(selectedStation.name)"
        }
        return result
    }
    
    var noResultsLabel: String { "No stations to show" }
}
