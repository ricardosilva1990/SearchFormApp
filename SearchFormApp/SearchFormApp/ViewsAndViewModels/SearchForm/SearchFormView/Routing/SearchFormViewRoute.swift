import SwiftUI

enum SearchFormViewRoute {
    case stationPickerView(type: StationType, selectedStation: StationViewModel?)
    case stationListView(title: String, selectedStation: Binding<StationViewModel?>, path: Binding<NavigationPath>)
    case passengerNumberView(number: Binding<Int>, passengerType: PassengerType)
    case tripSearchResultsView(model: TripSearchModel, isVisible: Binding<Bool>)
}
