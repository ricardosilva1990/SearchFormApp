protocol StationPickerViewModelProtocol {
    var selectedStation: StationViewModel? { get set }
    
    // MARK: - Label
    var title: String { get }
    var noValueLabel: String { get }
}

extension StationPickerViewModelProtocol {
    var noValueLabel: String { "No Station Selected" }
}
