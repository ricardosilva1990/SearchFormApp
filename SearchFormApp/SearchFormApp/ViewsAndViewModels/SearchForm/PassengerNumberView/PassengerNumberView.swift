import SwiftUI

struct PassengerNumberView<ViewModel: PassengerNumberViewModelProtocol>: View {
    let viewModel: ViewModel
    
    @Binding var selectedNumber: Int
    
    var body: some View {
        HStack {
            Stepper(viewModel.label, value: $selectedNumber, in: viewModel.range)
            Text("\(selectedNumber)")
        }
    }
}

struct PassengerNumberView_Previews: PreviewProvider {
    private struct BindingTestHolder: View {
        @State var selectedNumber: Int = 6
        
        var body: some View {
            let viewModel = PassengerNumberPreviewViewModel()
            PassengerNumberView(viewModel: viewModel, selectedNumber: $selectedNumber)
        }
    }
    
    static var previews: some View {
        BindingTestHolder()
    }
}
