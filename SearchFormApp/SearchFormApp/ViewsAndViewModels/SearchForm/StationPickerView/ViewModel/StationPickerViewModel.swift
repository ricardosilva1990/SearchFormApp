struct OriginStationPickerViewModel: StationPickerViewModelProtocol {
    var selectedStation: StationViewModel?
    
    // MARK: - Label
    var title: String { "Origin Station" }
}

struct DestinationStationPickerViewModel: StationPickerViewModelProtocol {
    var selectedStation: StationViewModel?
    
    // MARK: - Label
    var title: String { "Destination Station" }
}
