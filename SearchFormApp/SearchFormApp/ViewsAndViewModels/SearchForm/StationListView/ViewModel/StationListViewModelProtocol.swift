import Combine
import Foundation

protocol StationListViewModelProtocol: ObservableObject {
    var stationArray: [StationViewModel] { get }
    var stationArrayPublisher: Published<[StationViewModel]> { get }
    var stationArrayPublished: Published<[StationViewModel]>.Publisher { get }
    
    func fetchStationList()
    
    // MARK: - Labels
    var title: String { get set }
    func titleLabel(for selectedStation: StationViewModel?) -> String
    var noResultsLabel: String { get }
}
