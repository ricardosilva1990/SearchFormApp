import SwiftUI

struct StationPickerView: View {
    @Binding var selectedStation: StationViewModel?
    
    var body: some View {
        HStack {
            Text(viewModel.title)
            Spacer()
            if let selectedStation = selectedStation {
                Text(selectedStation.name)
            } else {
                Text(viewModel.noStationText)
                    .italic()
            }
        }
    }
}

struct StationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = StationPickerPreviewViewModel()
        StationPickerView()
    }
}
