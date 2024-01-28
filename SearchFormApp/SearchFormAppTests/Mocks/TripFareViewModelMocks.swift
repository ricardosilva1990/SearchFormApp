@testable import SearchFormApp

struct TripFareViewModelMocks {
    static let adult = TripFareViewModel(type: .adult, amount: 10.0, count: 3, discountAmount: 1.0)
    static let teen = TripFareViewModel(type: .teen, amount: 9.0, count: 2, discountAmount: 0.5)
    static let child = TripFareViewModel(type: .child, amount: 8.0, count: 1, discountAmount: 2.0)
}
