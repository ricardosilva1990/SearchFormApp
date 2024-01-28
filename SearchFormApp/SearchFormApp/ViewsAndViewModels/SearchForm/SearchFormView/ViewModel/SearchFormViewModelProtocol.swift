import Combine
import Foundation

protocol SearchFormViewModelProtocol: ObservableObject {
    var originStation: StationViewModel? { get set }
    var originStationPublished: Published<StationViewModel?> { get }
    var originStationPublisher: Published<StationViewModel?>.Publisher { get }
    
    var destinationStation: StationViewModel? { get set }
    var destinationStationPublished: Published<StationViewModel?> { get }
    var destinationStationPublisher: Published<StationViewModel?>.Publisher { get }
    
    var departureDate: Date { get set }
    var departureDatePublished: Published<Date> { get }
    var departureDatePublisher: Published<Date>.Publisher { get }
    
    var adult: Int { get set }
    var adultPublished: Published<Int> { get }
    var adultPublisher: Published<Int>.Publisher { get }
    
    var teen: Int { get set }
    var teenPublished: Published<Int> { get }
    var teenPublisher: Published<Int>.Publisher { get }
    
    var child: Int { get set }
    var childPublished: Published<Int> { get }
    var childPublisher: Published<Int>.Publisher { get }
    
    var tripSearchModel: TripSearchModel { get throws }
    var searchable: Bool { get }
    
    // MARK: - Labels
    var stationSectionLabel: String { get }
    var originStationLabel: String { get }
    var destinationStationLabel: String { get }
    
    var departureDateLabel: String { get }
    var departureDateMinimum: Date { get }
    
    var searchButtonLabel: String { get }
    
    var passengerNumberSectionLabel: String { get }
    
    var searchFormTitle: String { get }
}
