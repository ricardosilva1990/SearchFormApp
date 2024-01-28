import SwiftUI

protocol RoutingProtocol: ObservableObject {
    associatedtype Route
    associatedtype Body: View
    
    @ViewBuilder func view(for route: Route) -> Self.Body
    func pop()
}
