import Foundation
@testable import SearchFormApp

struct TripSearchModelMocks {
    static let barcelonaMadridTrip = TripSearchModel(
        origin: "BCN", destination: "MAD", departureDate: Date(), adultNumber: 3, teenNumber: 2, childNumber: 1
    )
}
