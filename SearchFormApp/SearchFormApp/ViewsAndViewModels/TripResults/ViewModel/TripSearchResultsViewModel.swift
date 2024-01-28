import Combine
import Foundation

class TripSearchResultsViewModel<Request: RequestProtocol>: TripSearchResultsViewModelProtocol where Request.ReturnType == TripResponseModel {
    var tripSearchModel: TripSearchModel
    let apiClient: APIClient
    let request: Request
    
    init(tripSearchModel: TripSearchModel, apiClient: APIClient, request: Request) {
        self.tripSearchModel = tripSearchModel
        self.apiClient = apiClient
        self.request = request
    }
    
    var publisher: AnyPublisher<[TripResponseViewModel], NetworkRequestError> {
        apiClient.dispatch(request)
            .map(\.tripResponseViewModelArray)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Labels
    var startDateLabel: String { "Start Date" }
    var endDateLabel: String { "End Date" }
    func label(for fare: TripFareViewModel) -> String { "Fare \(fare.type.description)" }
    func value(for fare: TripFareViewModel, with currency: String) -> String { "\(fare.count)x \(fare.finalAmount) \(currency)" }
    var noFareLabel: String { "No Fares Available" }
    var searchResultsTitle: String { "Search Results" }
    var confirmButtonLabel: String { "OK" }
    var noResultsLabel: String { "Nothing to show here..." }
}
