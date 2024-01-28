import SwiftUI

class StationListViewRouting: RoutingProtocol {
    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func view(for route: StationListViewRoute) -> some View {
        EmptyView() // nothing to do here
    }
    func pop() {
        path.removeLast()
    }
}
