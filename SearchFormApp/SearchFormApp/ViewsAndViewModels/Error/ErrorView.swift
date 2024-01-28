import SwiftUI

struct ErrorView: View {
    private let viewModel: ErrorViewModel = ErrorViewModel()
    
    var error: Error
    var retryHandler: () -> Void
    
    var body: some View {
        VStack {
            Text(error.localizedDescription)
            Button(viewModel.retryButtonLabel) {
                retryHandler()
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum PreviewError: Error {
        case cantShow
    }
    
    static var previews: some View {
        ErrorView(error: PreviewError.cantShow) {
            print("retried...")
        }
    }
}
