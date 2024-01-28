import SwiftUI

struct TripSearchResultsView<
    ViewModel: TripSearchResultsViewModelProtocol, Router: RoutingProtocol
>: View where Router.Route == TripSearchResultsViewRoute {
    @StateObject var viewModel: ViewModel
    @ObservedObject var router: Router
    
    var body: some View {
        LoadableView(source: viewModel.publisher) { tripResponseArray in
            NavigationStack {
                Group {
                    if tripResponseArray.isEmpty {
                        Text(viewModel.noResultsLabel)
                            .foregroundColor(.gray)
                    } else {
                        List {
                            ForEach(tripResponseArray, id: \.id) { trip in
                                Section {
                                    HStack {
                                        Text(viewModel.startDateLabel)
                                            .accessibilityIdentifier("TripStartDateLabel")
                                        Spacer()
                                        Text(trip.startDateLabel)
                                            .accessibilityIdentifier("TripStartDateValueText")
                                    }
                                    HStack {
                                        Text(viewModel.endDateLabel)
                                            .accessibilityIdentifier("TripEndDateLabel")
                                        Spacer()
                                        Text(trip.endDateLabel)
                                            .accessibilityIdentifier("TripEndDateValueText")
                                    }
                                    
                                    if let regularFare = trip.regularFare {
                                        ForEach(regularFare, id: \.id) { fare in
                                            HStack {
                                                Text(viewModel.label(for: fare))
                                                    .accessibilityIdentifier("FareLabel")
                                                Spacer()
                                                Text(viewModel.value(for: fare, with: trip.currency))
                                                    .accessibilityIdentifier("FareValue")
                                            }
                                        }
                                    } else {
                                        Text(viewModel.noFareLabel)
                                    }
                                } header: {
                                    Text(trip.flightNumber)
                                        .accessibilityIdentifier("TripSectionLabel")
                                    
                                }
                            }
                        }
                        .accessibilityIdentifier("TripSearchResultsList")
                    }
                }
                .navigationTitle(viewModel.searchResultsTitle)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(viewModel.confirmButtonLabel) {
                            router.pop()
                        }
                        .accessibilityIdentifier("ConfirmButton")
                    }
                }
            }
        }
    }
}
