import SwiftUI

class TripSearchResultsViewRouting: RoutingProtocol {
    @Binding private var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    func view(for route: TripSearchResultsViewRoute) -> some View {
        EmptyView() // nothing to do here
    }
    
    func pop() {
        isPresented = false
    }
}
