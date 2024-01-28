import Foundation
import SwiftUI

class SearchFormViewRouter: RoutingProtocol {
    @ViewBuilder func view(for route: SearchFormViewRoute) -> some View {
        switch route {
        case let .stationPickerView(type, selectedStation):
            self.stationPickerView(forType: type, and: selectedStation)
        case let .stationListView(title, selectedStation, path):
            self.stationListView(for: title, selectedStation, and: path)
        case let .passengerNumberView(number, passengerType):
            self.passengerNumberView(for: passengerType, and: number)
        case let .tripSearchResultsView(model, isVisible):
            self.tripSearchResultsView(for: model, and: isVisible)
        }
    }
    
    /// Nothing to pop to as it's the main view
    func pop() {}
}

private extension SearchFormViewRouter {
    @ViewBuilder func stationPickerView(forType type: StationType, and selectedStation: StationViewModel?) -> some View {
        switch type {
        case .origin:
            let viewModel = OriginStationPickerViewModel(selectedStation: selectedStation)
            StationPickerView(viewModel: viewModel)
        case .destination:
            let viewModel = DestinationStationPickerViewModel(selectedStation: selectedStation)
            StationPickerView(viewModel: viewModel)
        }
    }
    
    @ViewBuilder func stationListView(for title: String, _ selectedStation: Binding<StationViewModel?>, and path: Binding<NavigationPath>) -> some View {
        let urlSession = ProcessInfo.processInfo.arguments.contains("-isUITesting") ? URLSession.simulatedStationListURLSession : .shared
        let networkDispatcher = NetworkDispatcher(urlSession: urlSession)
        let apiClient = APIClient(baseURL: NetworkConfigurations.getStationsRequestBaseURL, networkDispatch: networkDispatcher)
        let request = GetStationsRequest()
        
        let viewModel = StationListViewModel(title: title, apiClient: apiClient, request: request)
        let router = StationListViewRouting(path: path)
        StationListView(viewModel: viewModel, router: router, selectedStation: selectedStation)
    }
    
    @ViewBuilder func passengerNumberView(for passengerType: PassengerType, and number: Binding<Int>) -> some View {
        switch passengerType {
        case .adult:
            PassengerNumberView(viewModel: AdultNumberViewModel(), selectedNumber: number)
        case .teen:
            PassengerNumberView(viewModel: TeenNumberViewModel(), selectedNumber: number)
        case .child:
            PassengerNumberView(viewModel: ChildNumberViewModel(), selectedNumber: number)
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
    
    func tripSearchResultsView(for model: TripSearchModel, and isVisible: Binding<Bool>) -> some View {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let urlSession = ProcessInfo.processInfo.arguments.contains("-isUITesting") ? URLSession.simulatedTripSarchResultsURLSession : .shared
        let networkDispatcher = NetworkDispatcher(urlSession: urlSession, decoder: jsonDecoder)
        let apiClient = APIClient(baseURL: NetworkConfigurations.getTripsRequestBaseURL, networkDispatch: networkDispatcher)
        let request = GetTripsRequest(queryItems: model.toDictionary)
        
        let viewModel = TripSearchResultsViewModel(tripSearchModel: model, apiClient: apiClient, request: request)
        let router = TripSearchResultsViewRouting(isPresented: isVisible)
        return TripSearchResultsView(viewModel: viewModel, router: router)
    }
}
