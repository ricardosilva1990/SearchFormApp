struct StationPickerPreviewViewModel: StationPickerViewModelProtocol {
    var selectedStation: StationViewModel? = StationViewModel(stationModel: StationModel(code: "STA", name: "Station"))
    
    var title: String { "Your Station" }
}
