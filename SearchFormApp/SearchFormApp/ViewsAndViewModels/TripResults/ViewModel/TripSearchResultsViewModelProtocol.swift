import Combine

protocol TripSearchResultsViewModelProtocol: ObservableObject {
    var tripSearchModel: TripSearchModel { get set }
    
    var publisher: AnyPublisher<[TripResponseViewModel], NetworkRequestError> { get }
    
    // MARK: - Labels
    var startDateLabel: String { get }
    var endDateLabel: String { get }
    func label(for fare: TripFareViewModel) -> String
    func value(for fare: TripFareViewModel, with currency: String) -> String
    var noFareLabel: String { get }
    var searchResultsTitle: String { get }
    var confirmButtonLabel: String { get }
    var noResultsLabel: String { get }
}
