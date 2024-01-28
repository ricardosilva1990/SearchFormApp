import Combine
import Foundation

class SearchFormViewModel: SearchFormViewModelProtocol {
    @Published var originStation: StationViewModel?
    var originStationPublished: Published<StationViewModel?> { _originStation }
    var originStationPublisher: Published<StationViewModel?>.Publisher { $originStation }
    
    @Published var destinationStation: StationViewModel?
    var destinationStationPublished: Published<StationViewModel?> { _destinationStation }
    var destinationStationPublisher: Published<StationViewModel?>.Publisher { $destinationStation }
    
    @Published var departureDate: Date = Date()
    var departureDatePublished: Published<Date> { _departureDate }
    var departureDatePublisher: Published<Date>.Publisher { $departureDate }
    
    @Published var adult: Int = 1
    var adultPublished: Published<Int> { _adult }
    var adultPublisher: Published<Int>.Publisher { $adult }
    
    @Published var teen: Int = 0
    var teenPublished: Published<Int> { _teen }
    var teenPublisher: Published<Int>.Publisher { $teen }
    
    @Published var child: Int = 0
    var childPublished: Published<Int> { _child }
    var childPublisher: Published<Int>.Publisher { $child }
    
    var tripSearchModel: TripSearchModel {
        get throws {
            guard let originStation = originStation, let destinationStation = destinationStation
            else { throw ConversionError.stationNotFilled }
            
            return TripSearchModel(
                origin: originStation.code,
                destination: destinationStation.code,
                departureDate: departureDate,
                adultNumber: adult,
                teenNumber: teen,
                childNumber: child
            )
        }
    }
    
    var searchable: Bool {
        originStation != nil && destinationStation != nil && originStation != destinationStation
    }
    
    // MARK: - Labels
    var stationSectionLabel: String { "Stations" }
    var originStationLabel: String { "Origin Station"}
    var destinationStationLabel: String { "Destination Station" }
    var departureDateLabel: String { "Departure Date" }
    var departureDateMinimum: Date { Date() }
    var passengerNumberSectionLabel: String { "Passenger Number" }
    var searchButtonLabel: String { "Search" }
    var searchFormTitle: String { "Search Form" }
}
