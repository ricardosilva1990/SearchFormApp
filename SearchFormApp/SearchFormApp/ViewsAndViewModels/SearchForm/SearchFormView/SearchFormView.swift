import SwiftUI

struct SearchFormView<ViewModel: SearchFormViewModelProtocol, Router: RoutingProtocol>: View where Router.Route == SearchFormViewRoute {
    @StateObject var router: Router
    @ObservedObject var searchFormViewModel: ViewModel
    
    @State private var path = NavigationPath()
    @State private var performSearch: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Form {
                    Section {
                        NavigationLink(value: StationType.origin) {
                            router.view(for: .stationPickerView(type: .origin, selectedStation: searchFormViewModel.originStation))
                                .accessibilityIdentifier("OriginStationPickerView")
                        }
                        
                        NavigationLink(value: StationType.destination) {
                            router.view(for: .stationPickerView(type: .destination, selectedStation: searchFormViewModel.destinationStation))
                                .accessibilityIdentifier("DestinationStationPickerView")
                        }
                    } header: {
                        Text(searchFormViewModel.stationSectionLabel)
                            .accessibilityIdentifier("StationSectionHeader")
                    }
                    
                    Section {
                        DatePicker(
                            searchFormViewModel.departureDateLabel,
                            selection: $searchFormViewModel.departureDate,
                            in: searchFormViewModel.departureDateMinimum...,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .accessibilityIdentifier("DepartureDatePicker")
                    } header: {
                        Text(searchFormViewModel.departureDateLabel)
                            .accessibilityIdentifier("DepartureDateSectionHeader")
                    }
                    
                    Section {
                        router.view(for: .passengerNumberView(number: $searchFormViewModel.adult, passengerType: .adult))
                            .accessibilityIdentifier("AdultPicker")
                        router.view(for: .passengerNumberView(number: $searchFormViewModel.teen, passengerType: .teen))
                            .accessibilityIdentifier("TeenPicker")
                        router.view(for: .passengerNumberView(number: $searchFormViewModel.child, passengerType: .child))
                            .accessibilityIdentifier("ChildPicker")
                    } header: {
                        Text(searchFormViewModel.passengerNumberSectionLabel)
                            .accessibilityIdentifier("PassengerPickerSectionHeader")
                    }
                }
                
                Button(searchFormViewModel.searchButtonLabel) {
                    performSearch = true
                }
                .disabled(!searchFormViewModel.searchable)
                .accessibilityIdentifier("SearchButton")
            }
            .navigationTitle(searchFormViewModel.searchFormTitle)
            .navigationDestination(for: StationType.self) { stationType in
                switch stationType {
                case .origin:
                    router.view(for: .stationListView(
                        title: searchFormViewModel.originStationLabel,
                        selectedStation: $searchFormViewModel.originStation,
                        path: $path
                    ))
                case .destination:
                    router.view(for: .stationListView(
                        title: searchFormViewModel.destinationStationLabel,
                        selectedStation: $searchFormViewModel.destinationStation,
                        path: $path
                    ))
                }
            }
            .fullScreenCover(isPresented: $performSearch) {
                if let tripSearchModel = try? searchFormViewModel.tripSearchModel {
                    router.view(for: .tripSearchResultsView(model: tripSearchModel, isVisible: $performSearch))
                }
            }
        }
    }
}

struct SearchFormView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchFormPreviewViewModel()
        SearchFormView(router: SearchFormViewRouter(), searchFormViewModel: viewModel)
    }
}
