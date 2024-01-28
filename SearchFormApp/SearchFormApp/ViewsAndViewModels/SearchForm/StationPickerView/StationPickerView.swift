import SwiftUI

struct StationPickerView<ViewModel: StationPickerViewModelProtocol>: View {
    let viewModel: ViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.title)
            Spacer()
            if let selectedStation = viewModel.selectedStation {
                Text(selectedStation.name)
            } else {
                Text(viewModel.noValueLabel)
                    .italic()
            }
        }
    }
}

struct StationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = StationPickerPreviewViewModel()
        StationPickerView(viewModel: viewModel)
    }
}
