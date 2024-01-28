protocol PassengerNumberViewModelProtocol {
    var label: String { get }
    var minimumNumber: Int { get }
    var maximumNumber: Int { get }
}

extension PassengerNumberViewModelProtocol {
    var range: ClosedRange<Int> {
        if minimumNumber <= maximumNumber {
            return minimumNumber...maximumNumber
        }
        return maximumNumber...minimumNumber
    }
}
